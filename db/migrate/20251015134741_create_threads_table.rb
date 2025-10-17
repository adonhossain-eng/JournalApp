class CreateThreadsTable < ActiveRecord::Migration[7.2]
  def change
    create_table "thread", force: :cascade do |t|
      t.string "entryID"
      t.datetime "date_created"
    end
  end
end
