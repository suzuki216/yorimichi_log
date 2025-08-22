class Post < ApplicationRecord
  before_validation :set_category
  
  belongs_to :user
  belongs_to :category, optional: true

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many_attached :images
  # キーワード検索
  scope :search_by_keyword, -> (keyword) {
    where("title LIKE :q OR body LIKE :q", q: "%#{keyword}%") if keyword.present?
  }
  # カテゴリ検索
  scope :search_by_category, -> (category_id) {
    where(category_id: category_id) if category_id.present?
  }
  
  attr_accessor :category_name, :remove_image_ids

  validates :title, :body, presence: true

  after_save :remove_selected_images

  private

  def set_category
    return if category_name.blank?
    self.category = Category.find_or_create_by(name: category_name)
  end


  def remove_selected_images
    return unless remove_image_ids
    images.where(id: remove_image_ids).purge
  end
end
