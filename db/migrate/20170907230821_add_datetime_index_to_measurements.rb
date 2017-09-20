class AddDatetimeIndexToMeasurements < ActiveRecord::Migration
  def change
    add_index :measurements, :date
  end
end
