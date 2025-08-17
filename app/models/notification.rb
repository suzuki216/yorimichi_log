class Notification < ApplicationRecord
  belongs_to :visitor
  belongs_to :visited
end
