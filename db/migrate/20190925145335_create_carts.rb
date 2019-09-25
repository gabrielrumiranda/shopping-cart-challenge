# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.float :shipping_price
      t.float :total_price
      t.string :user_token

      t.timestamps
    end
  end
end
