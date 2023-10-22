class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :item, null: false, foreign_key: true
      t.date :notify_date, null: false

      t.timestamps
    end
  end
end
