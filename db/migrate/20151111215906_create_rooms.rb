class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :sensor, index: true
    end
    add_foreign_key :rooms, :sensors
  end
end
