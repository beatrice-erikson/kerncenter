class Sensor < ActiveRecord::Base
	has_many :measurements
	belongs_to :subtype
	delegate :type, to: :subtype
	belongs_to :room
end