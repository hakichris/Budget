class CreateCatTransacts < ActiveRecord::Migration[7.0]
  def change
    create_table :cat_transacts do |t|
      t.references :financial_transaction, null: false, foreign_key: { to_table: :financial_transactions }, index: true
      t.references :category, null: false, foreign_key: { to_table: :categories }, index: true
      t.timestamps
    end
  end
end
