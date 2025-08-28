class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :reason, presence: true, length: { maximum: 500 }
  validates :user_id, uniqueness: { scope: :post_id, message: "は同じ投稿を重複して通報できません" }

end
