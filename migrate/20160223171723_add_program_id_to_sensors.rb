class AddProgramIdToSensors < ActiveRecord::Migration
  def change
	add_reference :sensors, :program, index: true
  end
end
