class Article < ApplicationRecord

   belongs_to :user
   attachment :image
   has_many :favorites, dependent: :destroy

   validates :title, presence: true
   validates :body, presence: true

   #ログイン中のユーザーがいいねしているかしていないかを判断」するメソッド
   def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	 end
	 
	 #検索条件メソッド
  def self.search_for(content, method)
    if method == 'perfect'
      Article.where(title: content)
    elsif method == 'forward'
      Article.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Article.where('title LIKE ?', '%'+content)
    else
      Article.where('title LIKE ?', '%'+content+'%')
    end
  end

   #以下タグ関連
   has_many :article_hashtag_relationships
   has_many :hashtags, through: :article_hashtag_relationships

   #DBへのコミット直前に実施する
   after_create do
    article = Article.find_by(id: self.id)
    hashtags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
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
    hashtags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end

end