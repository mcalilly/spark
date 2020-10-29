class Post < ApplicationRecord
  extend FriendlyId

  # title
  friendly_id :title, use: :slugged
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  # body
  has_rich_text :body
end
