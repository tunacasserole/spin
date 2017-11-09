class AdminsController < ApplicationController

  before_action :set_admin, only: [:show, :edit, :update]

  # GET /spark/admins
  # GET /spark/admins.json
  def index
    respond_to do |format|
      format.json {render json: process_search(Admin)}
      format.html
    end
  end


  # GET /spark/admins/1 (will redirect to edit)
  # GET /spark/admins/1.json
  def show
    respond_to do |format|
      format.html { redirect_to action: 'edit', id: @admin.id }
      format.json { render json: { rows: (@admin.nil? ? [] : [@admin.marshall]), status: (@admin.nil? ? 404 : 200), total: (@admin.nil? ? 0 : 1) } }
    end
  end # def show


  # GET /spark/admins/new
  # GET /spark/admins/new.json
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: { rows: (@admin.nil? ? [] : [@admin.marshall]), status: (@admin.nil? ? 404 : 200), total: (@admin.nil? ? 0 : 1) } }
    end
  end # def new


  # POST /spark/admins
  # POST /spark/admins.json
  def create
    @admin = Admin.new(admin_params)
    respond_to do |format|
      if @admin.save
        flash[:success] = 'The admin was successfully created.'
        format.html { redirect_to admin_url(@admin) }
        format.json { render json: { rows: [@admin.marshall], status: 200, total: 1 } }
      else
        notice = "Failed to save the admin. #{@admin.errors.full_messages.to_sentence} ."
        flash[:error] = notice
        format.html { render action: "new", alert: notice }
        format.json { render json: { errors: @admin.errors, status: :unprocessable_entity } }
      end
    end
  end # def create


  # GET /spark/admins/1/edit
  def edit
  end # def edit


  # PATCH /spark/admins/1
  # PATCH /spark/admins/1.json
  def update
    respond_to do |format|
      if @admin.update_attributes(admin_params)
        flash[:success] = 'The admin was successfully updated.'
        format.html { redirect_to @admin }
        format.json { render json: { rows: [@admin.marshall], status: 200, total: 1 } }
      else
        notice = "Failed to save the admin. #{@admin.errors.full_messages.to_sentence}."
        flash[:error] = notice
        format.html { render action: "edit", alert: notice }
        format.json { render json: { errors: @admin.errors, status: :unprocessable_entity } }
      end
    end
  end # def update


  # DELETE /spark/admins/1
  # DELETE /spark/admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { render json: { status: 200 } }
    end
  end

  private

  def set_admin
    @admin = current_admin || Admin.where( id: params[:id] ).first
  end

  # Returns the strong parameters from the request
  def admin_params
    params.require(:admin).permit(Admin.column_names, :password, :password_confirmation)
  end # def admin_params

end # class AdminsController
