class Review < ApplicationRecord
  belongs_to :ski_resort
  belongs_to :user

  validates :title, presence: true
  validates :title, length: { maximum: 15 }
  validates :rate, presence: true
  validates :comment, presence: true
end
