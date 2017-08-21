class RemoveRoomIdFromSensors < ActiveRecord::Migration
  def change
	remove_reference :sensors, :room
  end
end
