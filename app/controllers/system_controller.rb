class SystemController < ApplicationController
  before_action :redirect_if_not_system_admin

  def redirect_if_not_system_admin
    # redirect_to :root unless current_admin.system_role
  end


end # class SystemController
