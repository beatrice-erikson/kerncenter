class Program < ActiveRecord::Base
	has_many :room_program_time_maps
	has_many :rooms, :through => :room_program_time_maps
end