class SkiResort < ApplicationRecord
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :reviews

  validates :resort_name, presence: true
  validates :address, presence: true
  validates :ski_lift, presence: true
  validates :hp_url, presence: true
  validates :phone_number, presence: true
  validates :business_hours, presence: true
  validates :business_period, presence: true
  validates :adult_price, presence: true
  validates :kid_price, presence: true
  validates :senior_price, presence: true
  validates :snow_quality, presence: true
  validates :resort_feature, presence: true
  validates :introduction, presence: true
end
