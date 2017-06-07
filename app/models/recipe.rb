class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :ingredients, length: {minimum: 1}
  validates :steps, length: {minimum: 1}

  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :steps,
                                allow_destroy: true,
                                reject_if: :all_blank

  belongs_to :user

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }

  # def self.latest
  #   order(created_at: :desc)
  # end
end
