class SkiResort < ApplicationRecord
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :reviews

  validates :resort_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :adult_price, presence: true
  validates :kid_price, presence: true
  validates :senior_price, presence: true
  validates :ski_lift, presence: true
  validates :courses, presence: true
  validates :maximum_tilt, presence: true
  validates :maximum_distance, presence: true
  validates :resort_feature, presence: true
  validates :introduction, presence: true
  validates :hp_url, presence: true
  validate :time_before_finish
  validate :day_before_finish

  def time_before_finish
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "は開始日以降のものを選択してください") if end_time < start_time
  end

  def day_before_finish
    return if end_day.blank? || start_day.blank?
    errors.add(:end_day, "は開始日以降のものを選択してください") if end_day < start_day
  end
end
