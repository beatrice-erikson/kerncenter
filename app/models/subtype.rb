class Subtype < ActiveRecord::Base
	has_many :sensors
	belongs_to :type
	
	delegate :resource, to: :type, prefix: true
end