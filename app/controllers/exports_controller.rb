class ExportsController < SystemController

	def index
	end

	def export_artists
		Artist.export
		flash[:success] = 'The export completed succesfully.'
		notice = "An error occured while creating the album. #{@album.errors.full_messages.to_sentence}."
		flash[:error] = notice
	end
end
