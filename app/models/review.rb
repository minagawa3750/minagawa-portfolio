class Review < ApplicationRecord
  belongs_to :ski_resort
  belongs_to :user

  validates :title, presence: true, length: { maximum: 15, allow_blank: true }
  validates :rate, presence: true
  validates :comment, presence: true
end
