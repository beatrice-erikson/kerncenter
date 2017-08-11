class ChangeMeasurementAmountToFloat < ActiveRecord::Migration
  def change
	  change_column :measurements, :amount, :float
  end
end
