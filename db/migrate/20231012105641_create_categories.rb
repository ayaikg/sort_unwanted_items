class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :ancestry
      t.integer :items_count, null: false, default: 0

      t.timestamps
    end
    add_index :categories, :ancestry
  end
end
