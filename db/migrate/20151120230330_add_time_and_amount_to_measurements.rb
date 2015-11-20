class AddTimeAndAmountToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :time, :timestamp
    add_column :measurements, :amount, :integer
  end
end
