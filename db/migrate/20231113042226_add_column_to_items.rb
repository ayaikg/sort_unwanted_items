class AddColumnToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :disposed_at, :date
  end
end
