class Subtype < ActiveRecord::Base
	has_many :sensors
	has_many :measurements, through: :sensors
	belongs_to :type
	
	delegate :resource, to: :type, prefix: true
end