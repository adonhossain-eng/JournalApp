class Item < ApplicationRecord
  has_many :chat_messages, dependent: :destroy, foreign_key: "items_id"
end
