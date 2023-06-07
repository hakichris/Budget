class UsersController < ApplicationController
  def index
    @user = current_user
    @categories = Category.includes(:financial_transactions).all
  end
end
