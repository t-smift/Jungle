class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_username'], password: ENV['ADMIN_password']

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if category.save
      redirect_to [:admin, :categories], notice: 'Category Created!'
    else 
    render :new
    end
  end
 
  def category_params
    params.require(:category).permit(
      :name
    )
  end
end


