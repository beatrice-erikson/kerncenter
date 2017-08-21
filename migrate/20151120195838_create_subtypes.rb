class CreateSubtypes < ActiveRecord::Migration
  def change
    create_table :subtypes do |t|
      t.references :type, index: true
      t.string :name
    end
    add_foreign_key :subtypes, :types
  end
end
