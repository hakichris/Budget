class UsersController < ApplicationController
  def show
    @user = current_user
    @categories = Category.includes(:financial_transactions).all
  end
end
