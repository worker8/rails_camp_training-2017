class Recipe < ApplicationRecord
  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/normal/grumpy_cat.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, presence: true
  validates :ingredients, length: {minimum: 1}
  validates :steps, length: {minimum: 1}

  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  # has_many :recipe_comment_relationship, class_name: "Comment", dependent: :destroy
  has_one :search_index, dependent: :destroy
  has_many :comments, dependent: :destroy #, through: :recipe_comment_relationship
  has_many :bookmarks, dependent: :destroy
  has_many :user_activities, as: :target, dependent: :destroy

  # has_many :liked_recipe_relationships,
  #          class_name: "Like"

  belongs_to :user
  # , through: :liked_recipe_relationshipsx

  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :steps,
                                allow_destroy: true,
                                reject_if: :all_blank

  belongs_to :user

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }

  # SEARCH_QUERY_MAP = {
  #   "title","ingredients"
  # }
  # scope :search_ingredients, ->(query:) { where("title LIKE ?", "%#{query}%") }

  def self.search2(query)
    results1 = Recipe.where("title LIKE ?", "%#{query}%")

    results2 = Recipe.all.map do |recipe|
      r = recipe.ingredients.where("name LIKE ?", "%#{query}%")
      if r.count > 0
        recipe
      end
    end
    (results1 + results2).uniq.compact

  end
end
