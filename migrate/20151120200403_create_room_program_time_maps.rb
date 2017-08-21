class CreateRoomProgramTimeMaps < ActiveRecord::Migration
  def change
    create_table :room_program_time_maps do |t|
      t.references :room, index: true
      t.references :program, index: true
      t.timestamp :start
      t.timestamp :end
    end
    add_foreign_key :room_program_time_maps, :rooms
    add_foreign_key :room_program_time_maps, :programs
  end
end
