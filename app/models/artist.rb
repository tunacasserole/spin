require 'CSV'

class Artist < ApplicationRecord

	has_many :albums

	def self.export
		@artists = Artist.all

		CSV.open("db/exports/artists.csv", "wb") do |csv|
			csv << Artist.attribute_names
			Artist.all.each do |artist|
				csv << artist.attributes.values
			end
		end

	end
end
