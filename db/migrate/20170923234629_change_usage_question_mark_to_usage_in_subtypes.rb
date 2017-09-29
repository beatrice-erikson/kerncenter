class ChangeUsageQuestionMarkToUsageInSubtypes < ActiveRecord::Migration
  def change
    rename_column :subtypes, :usage?, :usage
  end
end
