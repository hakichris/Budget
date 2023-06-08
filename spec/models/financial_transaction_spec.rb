require 'rails_helper'

RSpec.describe FinancialTransaction, type: :model do
  before(:each) do
    @icon = fixture_file_upload('/icon.png', 'icon/png')
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Category.create(name: 'Test Category', icon: @icon, user: @user)
    @expense = FinancialTransaction.create(name: 'Test financial_transaction', amount: 100, author_id: @user.id)
  end
  it 'is valid with valid attributes' do
    expect(@expense).to be_valid
  end
  it 'is not valid without a name' do
    @expense.name = nil
    expect(@expense).to_not be_valid
  end
  it 'is not valid without an amount' do
    @expense.amount = nil
    expect(@expense).to_not be_valid
  end
  it 'is not valid without an author_id' do
    @expense.author_id = nil
    expect(@expense).to_not be_valid
  end
end
