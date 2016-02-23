class DropRoomProgramTimeMaps < ActiveRecord::Migration
  def change
	drop_table :room_program_time_maps
  end
end
