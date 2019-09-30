# Shopping Cart Challenge
[![Build Status](https://travis-ci.com/gabrielrumiranda/shopping-cart-challenge.svg?token=GfyTWppvNS6iqPXpPdBX&branch=master)](https://travis-ci.com/gabrielrumiranda/shopping-cart-challenge)
[![codecov](https://codecov.io/gh/gabrielrumiranda/shopping-cart-challenge/branch/master/graph/badge.svg?token=AjTcBBQAap)](https://codecov.io/gh/gabrielrumiranda/shopping-cart-challenge)

This is the result of the shopping cart challenge problem as described [here](https://gist.github.com/halan/8db191aa340a90b32310c0c956418824).

To run the application you will need:

* Postgresql
* Clone the project, `bundle install` and it should work.

To run the server
 ``` rails s ```
 
To run the tests
``` bundle exec rspec``` 

### Endpoints

#### Cart
* ``` GET api/carts ``` Retrieves a list of carts
* ``` GET api/carts/:id/checkout ``` Retrieves subtotal, total and shipping price of cart
* ``` GET api/carts/:id ``` Retrieves a specific cart
* ``` POST api/carts/ ``` Create a new cart 
* ``` DELETE /carts/:id ``` Delete a specific cart

#### Products
* ``` GET api/carts/:cart_id/products ``` Retrieves a list of procucts in a specific cart
* ``` GET api/carts/:cart_id/products/:product_id ``` Retrieves a specific product in a specific cart
* ``` POST api/carts/:cart_id/products ``` Create a new product in a specific cart
* ``` DELETE /carts/:cart_id/products/:product_id ``` Delete a specific product in a cart
* ``` PUT /carts/:cart_id/products/:product_id ``` Update a specific product in cart

#### Coupons
* ``` GET api/carts/:cart_id/coupons ``` Retrieves a list of coupons in a specific cart
* ``` GET api/carts/:cart_id/coupons/:coupon_id ``` Retrieves a specific coupon in a specific cart
* ``` POST api/carts/:cart_id/coupons ``` Create a new coupon in a specific cart
* ``` DELETE /carts/:cart_id/coupons/:coupon_id ``` Delete a specific coupon in a cart
* ``` PUT /carts/:cart_id/coupons/:coupon_id ``` Update a specific coupon in cart
