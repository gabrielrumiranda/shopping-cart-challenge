# frozen_string_literal: true

product_list = [
  ['Banana', 10, 1],
  ['Apple', 20, 1],
  ['Orange', 30, 1]
]

product_list.each do |name, price, amount|
  Product.create(name: name, price: price, amount: amount)
end
