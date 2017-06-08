class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy

  has_many :followed_user_relationships,
           foreign_key: :follower_id,
           class_name: "Follow",
           dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
           foreign_key: :followed_user_id,
           class_name: "Follow",
           dependent: :destroy
  has_many :followers, through: :follower_relationships

  has_many :liked_recipe_relationships,
           class_name: "Like",
           dependent: :destroy
  has_many :liked_recipes, through: :liked_recipe_relationships, source: :recipe

  has_many :bookmarked_recipe_relationships,
           class_name: "Bookmark",
           dependent: :destroy
  has_many :bookmarked_recipes, through: :bookmarked_recipe_relationships, source: :recipe

  has_many :feed_items, dependent: :destroy

  def owns?(object)
    object.user_id == id
  end

  def follows?(user)
    followed_users.include?(user)
  end

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.delete(user)
  end

  def likes?(recipe)
    liked_recipes.include?(recipe)
  end

  def likes(recipe)
    liked_recipes << recipe
  end

  def unlikes(recipe)
    liked_recipes.delete(recipe)
  end

  def bookmarks(recipe)
    # bookmarked_recipes << recipe
    bookmarked_recipe_relationships.find_or_create_by(recipe: recipe)
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def unbookmarks(recipe)
    bookmarked_recipes.delete(recipe)
  end

  def bookmarks?(recipe)
    bookmarked_recipes.include?(recipe)
  end

  def comment_on(recipe, comment_text)
    comment = Comment.new
    comment.user = self
    comment.recipe = recipe
    comment.text = comment_text
    comment.save
  end

end
