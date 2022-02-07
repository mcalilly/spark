class Issue < ApplicationRecord

  has_rich_text :body

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :body, presence: true

end
