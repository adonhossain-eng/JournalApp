class CreateThreadMessages < ActiveRecord::Migration[7.2]
  def change
    create_table "thread_message" do |t|
      t.string "threadID"
      t.string "sender"
      t.text "message"
      t.datetime "date_sent"
    end
  end
end
