class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  has_many :user_activities, as: :target, dependent: :destroy
end
