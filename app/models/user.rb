class User < ApplicationRecord
  has_many :categories
  has_many :financial_transactions, foreign_key: 'author_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 250 }
end
