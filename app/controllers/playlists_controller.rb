class ArtistsController < ApplicationController
  before_action :set_artist, except:  [:index, :new, :create]

  def export
    Artist.export
    # respond_to do |format|
    #   format.json { render json: process_search(Artist, search: '%') }
    #   format.html
    # end
  end


  def index
    @artists = Artist.all

    respond_to do |format|
      format.json { render json: process_search(Artist, search: '%') }
      format.html
    end
  end


  # GET /spin/artists/1 (will redirect to edit)
  # GET /spin/artists/1.json
  def show
    respond_to do |format|
      format.html { redirect_to action: 'edit', id: @artist.id }
      format.json do
        render json: { rows: (@artist.nil? ? [] : [@artist.marshall]),
         status: (@artist.nil? ? 404 : 200),
         total: (@artist.nil? ? 0 : 1) }
       end
     end
  end # def show

  # GET /spin/artists/new
  # GET /spin/artists/new.json
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json do
        render json: { rows: (@artist.nil? ? [] : [@artist.marshall]),
         status: (@artist.nil? ? 404 : 200),
         total: (@artist.nil? ? 0 : 1) }
       end
     end
  end # def new

  # POST /spin/artists
  # POST /spin/artists.json
  def create
    @artist = Artist.new(artist_params)
    respond_to do |format|
      if @artist.save
        flash[:success] = 'The artist was successfully created.'
        format.html { redirect_to artists_path }
        format.json { render json: { rows: [@artist.marshall], status: 200, total: 1 } }
      else
        notice = "An error occured while creating the artist. #{@artist.errors.full_messages.to_sentence}."
        flash[:error] = notice
        format.html { render action: 'new', alert: notice }
        format.json { render json: { errors: @artist.errors, status: :unprocessable_entity } }
      end
    end
  end # def create

  # GET /spin/artists/1/edit
  def edit
  end # def edit

  # PATCH /spin/artists/1
  # PATCH /spin/artists/1.json
  def update
    @artist = Artist.find(artist_params[:id])
    respond_to do |format|
      if @artist.update_attributes(artist_params)
        flash[:success] = 'The artist was successfully updated.'
        format.html { redirect_to edit_artist_url(@artist.id) }
        format.json { render json: { rows: [@artist.marshall], status: 200, total: 1 } }
      else
        base = 'Failed to save the artist. '
        flash[:error] = 'An error occured while updating the artist.'
        format.html { render action: 'edit', alert: base + @artist.errors.full_messages.to_sentence + '.' }
        format.json { render json: { errors: @artist.errors, status: :unprocessable_entity } }
      end
    end
  end # def update

  # DELETE /spin/artists/1
  # DELETE /spin/artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { render json: { status: 200 } }
    end
  end

  private

  def set_artist
    @artist = Artist.where(id: params[:id]).first
  end

  # Returns the strong parameters from the request
  def artist_params
    params.require(:artist).permit(Artist.column_names)
  end # def artist_params


end # class ArtistsController
