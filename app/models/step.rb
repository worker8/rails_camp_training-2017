class Step < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/normal/knife_icon.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :recipe
end
