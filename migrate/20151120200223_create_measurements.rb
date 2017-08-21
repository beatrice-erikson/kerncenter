class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.references :sensor, index: true
    end
    add_foreign_key :measurements, :sensors
  end
end
