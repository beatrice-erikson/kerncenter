class AddNameAndCodeToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :sensorName, :string
    add_column :sensors, :sensorCode, :string
  end
end
