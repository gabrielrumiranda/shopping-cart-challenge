# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.float :shipping_price
      t.integer :amount
      t.belongs_to :cart
      t.timestamps
    end
  end
end
