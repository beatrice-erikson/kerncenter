class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.references :sensor_type, index: true
    end
    add_foreign_key :sensors, :sensor_types
  end
end
