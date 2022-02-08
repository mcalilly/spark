class NewsClip < ApplicationRecord

  validates :publication, presence: true
  validates :publication_date, presence: true

end
