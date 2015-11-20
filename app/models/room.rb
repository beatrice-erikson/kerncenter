class Room < ActiveRecord::Base
	has_many :sensors
	has_many :room_program_time_maps
	has_many :programs, :through => :room_program_time_maps
end