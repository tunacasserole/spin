require 'csv'

class Artist < ApplicationRecord

	has_many :albums

	def self.export
		@artists = Artist.all

		CSV.open("db/exports/artists.csv", "wb") do |csv|
			csv << ['Artist Name', '# of Records', 'Record Year Range']
			Artist.all.each do |artist|
				albums = artist.albums.order(:year)
				range = "#{albums.first.year} - #{albums.last.year}"
				csv << [artist.name, artist.albums.count, range]
			end
		end

	end
end
