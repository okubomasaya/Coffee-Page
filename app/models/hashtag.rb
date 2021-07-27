class Hashtag < ApplicationRecord

  validates :hashname, presence: true, length: { maximum:99}
  has_many :article_hashtag_relationships
  has_many :articles, through: :article_hashtag_relationships

end