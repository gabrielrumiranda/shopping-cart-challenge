# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :cart do
      resources :products
      resources :coupons
    end
  end
end
