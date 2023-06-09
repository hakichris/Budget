class FinancialTransactionsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @financial_transaction = @category.financial_transactions.order(created_at: :desc)
  end

  def new
    @financial_transaction = current_user.financial_transactions.new
    @category = Category.find(params[:category_id])
  end

  def create
    @financial_transaction = current_user.financial_transactions.new(financial_transaction_params.slice(:name, :amount))

    if @financial_transaction.save
      @cat_transact = CatTransact.new(financial_transaction_id: @financial_transaction.id, category_id: params[:financial_transaction][:category_id])

      if @cat_transact.save
        redirect_to user_category_financial_transactions_path(current_user, params[:financial_transaction][:category_id]),
                    notice: 'financial_transaction created successfully'
      end
    else
      render :new
    end
  end

  def destroy
    @financial_transaction = FinancialTransaction.find(params[:id])
    @financial_transaction.destroy!
    flash[:notice] = 'Transaction has been successfully deleted!'
    redirect_to user_category_path(@financial_transaction.category_id)
  end

  private

  def financial_transaction_params
    params.require(:financial_transaction).permit!
  end
end
