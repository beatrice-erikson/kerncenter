class ChangeNameTimeToDateInMeasurements < ActiveRecord::Migration
  def change
	rename_column :measurements, :time, :date
  end
end
