class Category < ApplicationRecord
  belongs_to :user
  has_one_attached :icon
  has_many :cat_transacts, dependent: :destroy
  has_many :financial_transactions, through: :cat_transacts

  validates :name, presence: true, length: { maximum: 250 }

  def total(category_id)
    financial_transactions.joins(:cat_transacts).where(cat_transacts: { category_id: }).sum('financial_transactions.amount')
  end
end
