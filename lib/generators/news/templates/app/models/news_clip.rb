class NewsClip < ApplicationRecord
  default_scope { order(publication_date: :desc) }

  validates :publication, presence: true
  validates :publication_date, presence: true
  validates :headline, presence: true

end
