class UsersController < ApplicationController

  # def index
  #   response = { total: 10, current: 1, rows: User.where("name like :search", search: '%a%').limit(10) }

  #   respond_to do |format|

  #     format.json { render json: response.to_json }
  #     format.html

  #   end
  # end

  def index
    respond_to do |format|
      format.json { render json: process_search(User, search: '%') }
      # format.json { render json: process_search(User) }
      format.html
    end
  end

  def analytics
    respond_to do |format|
      format.json { render json: process_analytics(User, search: '%') }
      format.html
    end
  end

  def show
  end


end
