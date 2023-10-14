class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
