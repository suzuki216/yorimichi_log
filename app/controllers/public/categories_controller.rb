class Public::CategoriesController < ApplicationController
  def search
    keyword = params[:keyword]
    categories = if keyword.present?
                   Category.where("name LIKE ?", "%#{keyword}%").limit(10)
                 else
                   Category.none
                 end
    render json: categories.pluck(:id, :name)
  end
end
