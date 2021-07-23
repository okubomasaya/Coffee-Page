class Article < ApplicationRecord

   belongs_to :user
   attachment :image
   has_many :favorites, dependent: :destroy
   validates :title, presence: true
   validates :body, presence: true
   
   has_many :article_hashtag_relations
   has_many :hashtags, through: :article_hashtag_relations
   
   #ログイン中のユーザーがいいねしているかしていないかを判断」するメソッド
   def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	 end
   
   #DBへのコミット直前に実施する
   after_create do
    article = Article.find_by(id: self.id)
    hashtags  = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    article.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end

  before_update do 
    article = Article.find_by(id: self.id)
    article.hashtags.clear
    hashtags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end
  
end