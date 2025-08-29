class Post < ApplicationRecord
  before_validation :set_category
  
  belongs_to :user
  belongs_to :category, optional: true

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :images
  
  attr_accessor :category_name, :remove_image_ids

  validates :title, :body, presence: true

  after_save :remove_selected_images

  def favorited_by?(user)
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end

  def create_notification_comment!(current_user, comment_id)
    notification = current_user.active_notifications.new(
      visited_id: user_id, # 投稿者
      post_id: id,
      comment_id: comment_id,
      action: 'comment'
    )
    notification.save if notification.valid?
  end

  def create_notification_favorite!(current_user)
    notification = current_user.active_notifications.new(
      visited_id: user_id,
      post_id: id,
      action: 'favorite'
    )
    notification.save if notification.valid?
  end
  

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
