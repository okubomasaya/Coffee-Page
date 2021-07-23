class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
	has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :profile, length: { maximum: 200 }
  
  has_many :followed_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followed, through: :followed_relationships
  has_many :follower_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  
 #フォローしているかを確認するメソッド
  def followed?(user)
    followed_relationships.find_by(followed_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    followed_relationships.create!(followed_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    followed_relationships.find_by(followed_id: user.id).destroy
  end

  
end
