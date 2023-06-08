require 'rails_helper'

RSpec.describe 'Users', type: :request do
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
  describe 'GET /users' do
    it 'returns http success' do
      get users_path(user_id: @user.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path(user_id: @user.id)
      expect(response).to render_template('index')
    end

    it 'displays the group name' do
      get users_path(user_id: @user.id)
      expect(response.body).to include('Test group')
    end
  end
  describe 'GET /categories/new' do
    it 'returns http success' do
      get new_user_category_path(user_id: @user.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_category_path(user_id: @user.id)
      expect(response).to render_template('new')
    end
    it 'displays the new group form' do
      get new_user_category_path(user_id: @user.id)
      expect(response.body).to include('Back')
    end
  end
end
