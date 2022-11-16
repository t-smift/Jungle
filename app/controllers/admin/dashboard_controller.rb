class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_username"], password: ENV["ADMIN_password"]
  def show
    @categories_count = Category.count
    @products_count = Product.count
  end
 

end
