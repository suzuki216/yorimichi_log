class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
