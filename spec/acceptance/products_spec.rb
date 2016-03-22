require 'rails_helper'
require 'rake'
require "spec_helper"
require 'rspec_api_documentation/dsl'
require 'rspec_api_documentation_helper'
RSpec.resource "Product" do
  header "Content-Type","application/vnd.api+json"
  shared_context "product parameters" do
    parameter "type",<<-DESC, required: true
    The type of the resource. is always "products"
    DESC
    let "type" do
      "products"
    end
    parameter "title",<<-DESC,scope: :attributes
    The title of the product.
    DESC
    parameter "description",<<-DESC,scope: :attributes
    The description of the product.
    DESC
    parameter "quantity",<<-DESC,scope: :attributes
    The quantity of the product.
    DESC
    parameter "aauction-window-ends-at",<<-DESC,scope: :attributes
    The time when aauction of the product ends.
    DESC
    parameter "aauction-window-starts-at",<<-DESC,scope: :attributes
    The time when aauction of the product starts.
    DESC
    parameter "display-description",<<-DESC,scope: :attributes
    The display description of the product.
    DESC
    parameter "minimum-bid",<<-DESC,scope: :attributes
    The minimum bid of the product.
    DESC
    parameter "aauction",<<-DESC,scope: :relationships
    The aauction to which the product belongs.
    DESC
    parameter "seller",<<-DESC,scope: :relationships
    The seller of the product.
    DESC
  end
  post "/v1/products" do
    include_context "product parameters"
    # before do
    #   Project::Application.load_tasks
    #   Rake::Task["seed:bid_types"].execute
    # end
    let "title" do
      "i love jesus"
    end
    let "description" do
      "for i have good plans for you"
    end
    let "quantity" do
      4
    end
    let "aauction-window-starts-at" do
      Time.utc(2016,02,06,11.0).as_json
    end
    let "aauction-window-ends-at" do
        Time.utc(2016,02,06,13.0).as_json
    end
    let "display-description" do
      "images"
    end
    let "minimum-bid" do
      8_000
    end
    # let "bid-type" do
    #   {
    #     data: {
    #       id: BidType.first.id.to_s,
    #       type: "bid-types"
    #     }
    #   }
    # end
    let! :persisted_aauction do
      FactoryGirl.create(:aauction)
    end
    let "aauction" do
      {
        data: {
          type: "aauctions",
          id: persisted_aauction.id.to_s
          }
      }
    end
    let! :persisted_user do
      FactoryGirl.create(:user)
    end
    let "seller" do
      {
        data: {
          type: "users",
          id: persisted_user.id.to_s
        }
      }
    end
    example_request "POST /v1/products" do
      expect(status).to eq 201
    end
  end
  patch "/v1/products/:product_id" do
    include_context "product parameters"
    parameter "id",<<-DESC, required: true
    The id of the product
    DESC
    let "id" do
      persisted_product.id.to_s
    end
    let! :persisted_product do
      FactoryGirl.create(:product)
    end
    let "product_id" do
      persisted_product.id.to_s
    end
    let "title" do
      "he indeed loves me"
    end
    example_request "PATCH /v1/products/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end
  get "/v1/products/:product_id" do
    let! :persisted_product do
      FactoryGirl.create(:product)
    end
    let "product_id" do
      persisted_product.id.to_s
    end
    example_request "GET /v1/products/:id" do
      expect(status).to eq 200
    end

  end
  get "/v1/products" do
    let! :persisted_product do
      FactoryGirl.create(:product)
    end
    let "product_id" do
      persisted_product.id.to_s
    end
    example_request "GET /v1/products" do
      expect(status).to eq 200
    end
  end
  delete "/v1/products/:product_id" do
    let! :persisted_product do
      FactoryGirl.create(:product)
    end
    let "product_id" do
      persisted_product.id.to_s
    end
    example_request "DELETE /v1/products/:id" do
      expect(status).to eq 204
    end
  end
end
