class Item < ApplicationRecord
  belongs_to :user
  has_many :chat_messages, dependent: :destroy, foreign_key: "items_id"
end
