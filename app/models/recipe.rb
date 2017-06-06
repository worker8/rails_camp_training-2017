class Recipe < ApplicationRecord
  validates :title, presence: true
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if: :all_blank
  belongs_to :user

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }

  # def self.latest
  #   order(created_at: :desc)
  # end
end
