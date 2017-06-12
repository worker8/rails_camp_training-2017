class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  belongs_to :recipe, counter_cache: true

  has_many :user_activities, as: :target, dependent: :destroy

end
