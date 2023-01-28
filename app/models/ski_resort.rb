class SkiResort < ApplicationRecord
  has_one_attached :resort_image
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :reviews
  has_many :likes

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
    errors.add(:end_time, "は営業開始時間以降のものを選択してください") if end_time < start_time
  end

  def day_before_finish
    errors.add(:end_day, "は営業開始日以降のものを選択してください") if end_day < start_day
  end

  def liked?(user)
    likes.exists?(user_id: user.id)
  end
end
