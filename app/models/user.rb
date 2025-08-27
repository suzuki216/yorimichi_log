class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  validates :email, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :first_name, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = 'ゲスト'
      user.first_name = 'ユーザー'
    end
  end

  def guest?
    email == "guest@example.com"
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def active_for_authentication?
    super && is_active
  end
  
end
