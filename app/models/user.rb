class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         #SNS認証
         :omniauthable, omniauth_providers: %i[google_oauth2] 

  has_many :articles
	has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false

 
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :profile, length: { maximum: 200 }
  
  #DBにwhereで検索したオブジェクトが存在しなければ処理を行わず、あればuserオブジェクトにdo以降の処理入力
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  #createとsave
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォロー外すメソッド               
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしているか確認するメソッド
  def following?(user)
    followings.include?(user)
  end

  #検索条件メソッド　あいまい検索のみに変更
  def self.search_for(content, method)
    # if method == 'perfect'
    #   User.where(name: content)
    # elsif method == 'forward'
    #   User.where('name LIKE ?', content + '%')
    # elsif method == 'backward'
    #   User.where('name LIKE ?', '%' + content)
    # else
      User.where('name LIKE ?', '%' + content + '%')
    # end
  end

end