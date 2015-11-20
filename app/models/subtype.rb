class Subtype < ActiveRecord::Base
	has_many :sensors
	belongs_to :type
end