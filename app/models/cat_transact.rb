class CatTransact < ApplicationRecord
  belongs_to :category
  belongs_to :financial_transaction
end
