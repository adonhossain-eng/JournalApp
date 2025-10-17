class RemoveThread < ActiveRecord::Migration[7.2]
  def change
    drop_table :thread
  end
end
