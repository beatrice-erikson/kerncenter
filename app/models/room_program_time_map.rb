class RoomProgramTimeMap < ActiveRecord::Base
	belongs_to :room
	belongs_to :program
end