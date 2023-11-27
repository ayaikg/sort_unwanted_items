class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :icon
      t.integer :items_count, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :categories, [:user_id, :title], unique: true
  end
end
