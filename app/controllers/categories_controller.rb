class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)
    @category.user = current_user
    @category.icon.attach(params[:category][:icon])

    if @category.save
      flash[:success] = 'category created successfully'
      redirect_to users_path(user_id: current_user.id)
    else
      flash[:alert] = 'error creating category'
    end
  end

  def show
    @user = current_user
    @category = Category.find(params[:id])
    @cattransaction = @category.cat_transacts.includes([:financial_transaction])
    @total = @cattransaction.sum(:amount)
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
