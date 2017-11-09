class DashboardsController < ApplicationController
  def index
  	@artists = Artist.select("artists.*, COUNT(albums.id) album_count").joins(:albums).group("artists.id").order("album_count DESC").limit(5)
  	# @albums = Album.select("COUNT(albums.id)").group("albums.year").order("album_count DESC")
  	@albums_by_year = {all: [[1950, 90], [1960, 40], [1970, 80], [1980, 20], [1990, 90], [2000, 20], [2010, 60]], favorites: [[1950, 80], [1960, 30], [1970, 70], [1980, 10], [1990, 80], [2000, 10], [2010, 50]]}
  end

  def support
  end

end

