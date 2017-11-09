class AlbumsController < ApplicationController
  before_action :set_album, except:  [:index,:new,:create]

  def index
    @albums = Album.order(:name)

    respond_to do |format|
      format.json { render json: process_search(Album, search: '%') }
      format.html
    end
  end


  # GET /spin/albums/1 (will redirect to edit)
  # GET /spin/albums/1.json
  def show
    respond_to do |format|
      format.html { redirect_to action: 'edit', id: @album.id }
      format.json do
        render json: { rows: (@album.nil? ? [] : [@album.marshall]),
         status: (@album.nil? ? 404 : 200),
         total: (@album.nil? ? 0 : 1) }
       end
     end
  end # def show

  # GET /spin/albums/new
  # GET /spin/albums/new.json
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json do
        render json: { rows: (@album.nil? ? [] : [@album.marshall]),
         status: (@album.nil? ? 404 : 200),
         total: (@album.nil? ? 0 : 1) }
       end
     end
  end # def new

  # POST /spin/albums
  # POST /spin/albums.json
  def create
    @album = Album.new(album_params)
    respond_to do |format|
      if @album.save
        flash[:success] = 'The album was successfully created.'
        format.html { redirect_to albums_path }
        format.json { render json: { rows: [@album.marshall], status: 200, total: 1 } }
      else
        @albums = Album.all
        notice = "An error occured while creating the album. #{@album.errors.full_messages.to_sentence}."
        flash[:error] = notice
        format.html { render action: 'index', alert: notice }
        format.json { render json: { errors: @album.errors, status: :unprocessable_entity } }
      end
    end
  end # def create

  # GET /spin/albums/1/edit
  def edit
  end # def edit

  # PATCH /spin/albums/1
  # PATCH /spin/albums/1.json
  def update
    @album = Album.find(album_params[:id])
    respond_to do |format|
      if @album.update_attributes(album_params)
        flash[:success] = 'The album was successfully updated.'
        format.html { redirect_to edit_album_url(@album.id) }
        format.json { render json: { rows: [@album.marshall], status: 200, total: 1 } }
      else
        base = 'Failed to save the album. '
        flash[:error] = 'An error occured while updating the album.'
        format.html { render action: 'edit', alert: base + @album.errors.full_messages.to_sentence + '.' }
        format.json { render json: { errors: @album.errors, status: :unprocessable_entity } }
      end
    end
  end # def update

  # DELETE /spin/albums/1
  # DELETE /spin/albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { render json: { status: 200 } }
    end
  end

  private

  def set_album
    @album = Album.where(id: params[:id]).first
  end

  # Returns the strong parameters from the request
  def album_params
    params.require(:album).permit(Album.column_names)
  end # def album_params


end # class AlbumsController
