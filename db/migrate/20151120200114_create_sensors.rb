class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.references :subtype, index: true
      t.references :room, index: true
    end
    add_foreign_key :sensors, :subtypes
    add_foreign_key :sensors, :rooms
  end
end
