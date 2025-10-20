class ChatMessage < ApplicationRecord
  belongs_to :item, optional: true
  enum sender: { user: 0, ai: 1 }
  validates :content, presence: true
end
