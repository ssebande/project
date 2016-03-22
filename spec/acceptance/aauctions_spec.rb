require 'rails_helper'
require 'rake'
require "spec_helper"
require 'rspec_api_documentation/dsl'
require 'rspec_api_documentation_helper'
RSpec.resource "Aauctions" do
  header "Content-Type","application/vnd.api+json"
  shared_context "aauction parameters" do
    parameter "type",<<-DESC, required: true
    The type of the resource. is always "aauctions"
    DESC
    let "type" do
      "aauctions"
    end
    parameter "organization",<<-DESC, scope: :relationships,required: true
    The organization to which the aauction belongs
    DESC
    parameter "starts-at",<<-DESC,scope: :attributes,required: true
    The time at which the aauction starts-at
    DESC
    parameter "ends-at",<<-DESC,scope: :attributes,required: true
    The time at which the aauction ends
    DESC
    parameter "time-zone-id",<<-DESC,scope: :attributes,required: true
    The time zone id should be used to localise the aauction time
    DESC
    parameter "physical-address",<<-DESC,scope: :attributes
    The place where the aauction items will be located
    DESC
    parameter "product-window-ends-at",<<-DESC,scope: :attributes
    The ending time of registering new products
    DESC
    parameter "name",<<-DESC,scope: :attributes
    The name of the aauction
    DESC
  end
  post "/v1/aauctions" do
    include_context "aauction parameters"
    let! :persisted_aauction do
      FactoryGirl.create(:aauction)
    end
    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end
    let "product-window-ends-at" do
      Time.utc(2016,02,05,11.0).as_json
    end
    let "starts-at" do
      Time.utc(2016,02,06,11.0).as_json
    end
    let "ends-at" do
      Time.utc(2016,02,06,13.0).as_json
    end
    let "time-zone-id" do
      "America/New_York"
    end
    let "physical-address" do
      "kampala uganda"
    end
    let "name" do
      "selling matooke"
    end
    let "aauction" do
      {
          data: {
            type: "aauctions",
            id: persisted_aauction.id.to_s

        }
      }
    end
    let "organization" do
      {
        data: {
          type: "organizations",
          id: persisted_organization.id.to_s
        }
      }
    end
    example_request "POST /v1/aauctions" do
      expect(status).to eq 201
      aauction = JSON.parse(response_body)
      expect(aauction["data"]["attributes"]["starts-at"]).to eq public_send("starts-at")
    end
  end
  patch "/v1/aauctions/:aauction_id" do
    include_context "aauction parameters"

    let! :persisted_aauction do
      FactoryGirl.create(:aauction)
    end
    let :aauction_id do
      persisted_aauction.id.to_s
    end
    parameter "id",<<-DESC,required: true
    The id of the aauction
    DESC
    let "id" do
      persisted_aauction.id.to_s
    end
    let "name" do
      "kawempe"
    end
    example_request "PATCH /v1/aauctions/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["name"]).to eq public_send("name")

    end
  end
  get "/v1/aauctions" do
    before do
      FactoryGirl.create(:aauction)
    end
    example_request "GET /v1/aauctions" do
      expect(status).to eq 200
    end
  end
  get "/v1/aauctions/:aauction_id" do
    let! :persisted_aauction do
      FactoryGirl.create(:aauction)
    end
    let :aauction_id do
      persisted_aauction.id.to_s
    end
    example_request "GET /v1/aauctions/:id" do
      expect(status).to eq 200
    end
  end
  delete "/v1/aauctions/:aauction_id" do
    let! :persisted_aauction do
      FactoryGirl.create(:aauction)
    end
    let :aauction_id do
      persisted_aauction.id.to_s
    end
    example_request "DELETE /v1/aauctions/:id" do
      expect(status).to eq 204
    end
  end
end
