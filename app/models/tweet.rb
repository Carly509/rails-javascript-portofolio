class Tweet < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    # dependent: :destroy means the comments related
    # to the specific post in mention get deleted if the post does.
  validates :user_id, presence: true
  validates :tweet, presence: true, length: { maximum: 120 }
  default_scope -> { order(created_at: :desc) }
end
