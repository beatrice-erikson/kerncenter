class AddUsageToSubtypes < ActiveRecord::Migration
  def change
    add_column :subtypes, :usage?, :boolean
  end
end
