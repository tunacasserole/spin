class Album < ApplicationRecord
	belongs_to :artist
	CONDITIONS=['poor','fair','good','pristine']

end
