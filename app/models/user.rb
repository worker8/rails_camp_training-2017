class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy

  has_many :followed_user_relationships,
           foreign_key: :follower_id,
           class_name: "Follow"
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
           foreign_key: :followed_user_id,
           class_name: "Follow"
  has_many :followers, through: :follower_relationships

  def owns?(object)
    object.user_id == id
  end

  def follow(user)
    followed_users << user
  end

  def follows?(user)
    followed_users.include?(user)
  end

  def unfollow(user)
    followed_users.delete(user)
  end

end
