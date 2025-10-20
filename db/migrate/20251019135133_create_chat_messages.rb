class CreateChatMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_messages do |t|
      t.references :items, null: false, foreign_key: true
      t.integer :sender
      t.text :content
      t.timestamp :time_sent, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
