class FinancialTransaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :cat_transacts, dependent: :destroy
  has_many :categories, through: :cat_transacts

  validates :name, presence: true, length: { maximum: 250 }
  validates :amount, presence: true
end
