class CreateRoomProgramTimeMapping < ActiveRecord::Migration
  def change
    create_table :room_program_time_mappings do |t|
      t.references :room, index: true
      t.references :program, index: true
      t.timestamp :start
      t.timestamp :end
    end
    add_foreign_key :room_program_time_mappings, :rooms
    add_foreign_key :room_program_time_mappings, :programs
  end
end
