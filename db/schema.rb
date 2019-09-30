# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_925_145_347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'carts', force: :cascade do |t|
    t.float 'shipping_price'
    t.float 'total_price'
    t.float 'subtotal_price'
    t.string 'user_token'
    t.float 'free_shipping_limit'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'coupons', force: :cascade do |t|
    t.string 'name'
    t.string 'coupon_type'
    t.bigint 'cart_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['cart_id'], name: 'index_coupons_on_cart_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.integer 'price'
    t.float 'shipping_price'
    t.integer 'amount'
    t.bigint 'cart_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['cart_id'], name: 'index_products_on_cart_id'
  end
end
