class DropThreadMessage < ActiveRecord::Migration[7.2]
  def change
    drop_table :thread_message
  end
end
