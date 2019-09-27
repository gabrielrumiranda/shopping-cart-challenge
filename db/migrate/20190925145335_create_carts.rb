# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.float :shipping_price
      t.float :total_price
      t.float :subtotal_price
      t.string :user_token
      t.float :free_shipping_limit
      t.timestamps
    end
  end
end
