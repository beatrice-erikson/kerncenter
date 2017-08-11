class ChangeDateToDateStampFromMeasurements < ActiveRecord::Migration
  def change
	  change_column(:measurements, :date, :timestamp)
  end
end
