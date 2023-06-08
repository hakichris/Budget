require 'rails_helper'

RSpec.describe CatTransact, type: :model do
  before(:each) do
    @icon = fixture_file_upload('/icon.png', 'icon/png')
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Category.create(name: 'Test group', icon: @icon, user: @user)
    @expense = FinancialTransaction.create(name: 'Test expense', amount: 100, author_id: @user.id)
    @expense_group = CatTransact.create(financial_transaction_id: @expense.id, category_id: @group.id)
  end
  it 'is valid with valid attributes' do
    expect(@expense_group).to be_valid
  end
  it 'is not valid without an expense_id' do
    @expense_group.financial_transaction_id = nil
    expect(@expense_group).to_not be_valid
  end
  it 'is not valid without a group_id' do
    @expense_group.category_id = nil
    expect(@expense_group).to_not be_valid
  end
end
