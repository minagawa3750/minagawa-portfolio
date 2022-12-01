class Review < ApplicationRecord
  belongs_to :ski_resort
  belongs_to :user

  validates :title, presence: true
  validates :comment, presence: true
  validates :rate, presence: true
end
