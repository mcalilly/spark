class Post < ApplicationRecord
  extend FriendlyId

  # title
  friendly_id :title, use: :slugged
  validates :title, presence: true

  # body
  has_rich_text :body
end
