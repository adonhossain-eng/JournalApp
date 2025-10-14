class AddColumnsToItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :items, :link, :string
  end
end
