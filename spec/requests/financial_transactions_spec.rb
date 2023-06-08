require 'rails_helper'

RSpec.describe 'Financial_transactions', type: :request do
  include Devise::Test::IntegrationHelpers # Include Devise test helpers
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @icon = fixture_file_upload('/icon.png', 'icon/png')

    @group = Category.create(name: 'Test group', icon: @icon, user: @user)
    @expense = FinancialTransaction.create(name: 'Test expense', amount: 100, author_id: @user.id)
    @expense_group = CatTransact.create(financial_transaction_id: @expense.id, category_id: @group.id)
    sign_in @user
  end
  describe 'GET /financial_transactions' do
    it 'returns http success' do
      get user_category_financial_transactions_path(user_id: @user.id, category_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the index template' do
      get user_category_financial_transactions_path(user_id: @user.id, category_id: @group.id)
      expect(response).to render_template('index')
    end
    it 'displays the expense name' do
      get user_category_financial_transactions_path(user_id: @user.id, category_id: @group.id)
      expect(response.body).to include('Transaction No')
    end
  end
  describe 'GET /expenses/new' do
    it 'returns http success' do
      get new_user_category_financial_transaction_path(user_id: @user.id, category_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_category_financial_transaction_path(user_id: @user.id, category_id: @group.id)
      expect(response).to render_template('new')
    end
    it 'displays the new expense form' do
      get new_user_category_financial_transaction_path(user_id: @user.id, category_id: @group.id)
      expect(response.body).to include('Transaction')
    end
  end
end
