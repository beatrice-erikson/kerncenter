class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :resource
    end
  end
end
