class FixThreadId < ActiveRecord::Migration[7.2]
  def change
    rename_column "thread_message", "threadID", "item_id"
  end
end
