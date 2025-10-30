class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password

      t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    end
  end
end
