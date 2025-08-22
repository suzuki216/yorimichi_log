class Public::CategoriesController < ApplicationController
  def seach
    if params[:keyword].present?
      @categories = Category.where("name LIKE ?", "%#{params[:keyword]}%")
    else
      @categories = Category.none
    end
  
    respond_to do |format|
      format.json { render json: @categories.pluck(:id, :name) }
    end
  end
end
