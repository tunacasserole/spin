class ExportsController < SystemController

  def index
  end

  def export_artists
  	Artist.export
  end
end
