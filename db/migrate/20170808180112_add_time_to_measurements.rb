class AddTimeToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :time, :time
  end
end
