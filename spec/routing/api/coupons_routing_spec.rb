require "rails_helper"

RSpec.describe Api::CouponsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/coupons").to route_to("api/coupons#index")
    end

    it "routes to #show" do
      expect(:get => "/api/coupons/1").to route_to("api/coupons#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/coupons").to route_to("api/coupons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/coupons/1").to route_to("api/coupons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/coupons/1").to route_to("api/coupons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/coupons/1").to route_to("api/coupons#destroy", :id => "1")
    end
  end
end
