class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲストユーザー'
    end
  end

  has_one_attached :image
  validates :name, presence: true
  validates :password_confirmation, presence: true, on: :create
  has_many :ski_resorts
  has_many :reviews
  has_many :likes
end
