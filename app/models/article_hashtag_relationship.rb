class ArticleHashtagRelationship < ApplicationRecord

  belongs_to :article
  belongs_to :hashtag
  with_options presence: true do
    validates :article_id
    validates :hashtag_id
  end

end
