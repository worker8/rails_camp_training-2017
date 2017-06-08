class UserActivity < ApplicationRecord
  validates :type, presence: true

  belongs_to :user
  belongs_to :target, polymorphic: true
  has_many :feed_items, dependent: :destroy

  delegate :username, to: :user

  # def to_partial_path
  #   "user_activities/#{action}_activity"
  # end
end
