# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :carts do
      get :checkout
      resources :products
      resources :coupons
    end
  end
end
