# frozen_string_literal: true

class CreateGroup < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :icon_user, null: false, foreign_key: { to_table: :users }, index: true
      t.references :icon_entity, null: false, foreign_key: { to_table: :entities }, index: true
      t.timestamps
    end
  end
end
