class ChangeMeasurementDateFormat < ActiveRecord::Migration
  def self.up
    change_table :measurements do |t|
      t.change :time, :date
    end
  end
  def self.down
    change_table :measurements do |t|
      t.change :time, :datetime
    end
  end
end