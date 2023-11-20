class CreateDeclutterings < ActiveRecord::Migration[7.0]
  def change
    create_table :declutterings do |t|
      t.integer :goal_amount, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
