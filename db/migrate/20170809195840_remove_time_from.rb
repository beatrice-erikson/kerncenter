class RemoveTimeFrom < ActiveRecord::Migration
  def change
	  remove_column :measurements, :time
  end
end
