class RemoveItemIdFromItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :items, :item_id, :string
  end
end
