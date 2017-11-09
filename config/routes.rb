# == Route Map
#
#                    Prefix Verb   URI Pattern                     Controller#Action
#                      root GET    /                               dashboards#index
#         new_admin_session GET    /admins/sign_in(.:format)       admins/sessions#new
#             admin_session POST   /admins/sign_in(.:format)       admins/sessions#create
#     destroy_admin_session DELETE /admins/sign_out(.:format)      admins/sessions#destroy
#        new_admin_password GET    /admins/password/new(.:format)  admins/passwords#new
#       edit_admin_password GET    /admins/password/edit(.:format) admins/passwords#edit
#            admin_password PATCH  /admins/password(.:format)      admins/passwords#update
#                           PUT    /admins/password(.:format)      admins/passwords#update
#                           POST   /admins/password(.:format)      admins/passwords#create
# cancel_admin_registration GET    /admins/cancel(.:format)        admins#cancel
#    new_admin_registration GET    /admins/sign_up(.:format)       admins#new
#   edit_admin_registration GET    /admins/edit(.:format)          admins#edit
#        admin_registration PATCH  /admins(.:format)               admins#update
#                           PUT    /admins(.:format)               admins#update
#                           DELETE /admins(.:format)               admins#destroy
#                           POST   /admins(.:format)               admins#create
#                 dashboard GET    /dashboard(.:format)            dashboards#index
#

Rails.application.routes.draw do

  root to: 'dashboards#index'

  get 'dashboard', to: 'dashboards#index'
  get 'support', to: 'dashboards#support'


  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins'
  }

  resources :admins
  resources :albums
  resources :artists

  put 'export_artists', to: 'artists#export'

  resources :imports
  resources :exports

  resources :users

end
