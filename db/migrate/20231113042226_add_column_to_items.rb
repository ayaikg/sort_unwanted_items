class AddColumnToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :disposal_at, :date
  end
end
