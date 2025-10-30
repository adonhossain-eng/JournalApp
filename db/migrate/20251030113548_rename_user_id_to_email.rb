class RenameUserIdToEmail < ActiveRecord::Migration[7.2]
  def change
    rename_column :items, :user_id, :email
  end
end
