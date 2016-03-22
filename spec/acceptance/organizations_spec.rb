require 'rails_helper'
require 'rake'
require "spec_helper"
require 'rspec_api_documentation/dsl'
require 'rspec_api_documentation_helper'
RSpec.resource "Organizations" do
  header "Content-Type","application/vnd.api+json"

  shared_context "organization parameters" do
    parameter "type",<<-DESC,required: true
    The type of the resource must be 'organizations'
    DESC
    let "type" do
      "organizations"
    end
    parameter "name",<<-DESC,scope: :attributes, required: true
    The name of the organization
    DESC
    let "name" do
      "Uganda Revenue Authority"
    end
  end
   shared_context "with a persisted organization" do
	let! :persisted_organization do
	 FactoryGirl.create(:organization)
     end
	let "organization_id" do
		persisted_organization.id.to_s
	end
end
  post "/v1/organizations" do
    include_context "organization parameters"
    before do
     @current_user = FactoryGirl.create(:user)
     access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @current_user.id)
     header "Authorization", "Bearer #{access_token.token}"
   end

    example_request "POST /v1/organizations" do

      expect(status).to eq 201
      organization = Organization.find(JSON.parse(response_body)["data"]["id"].to_i)
      # expect(organization.memberships.find { |m| m.user == @current_user }).not_to be_nil
    end
  end
  get "/v1/organizations/:organization_id" do
    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end
    let "organization_id" do
      persisted_organization.id.to_s
    end
    let "name" do
      "Police"
    end
    example_request "GET /v1/organizations/:id" do
      expect(status).to eq 200
    end
  end
  patch "/v1/organizations/:organization_id" do
    include_context "organization parameters"
    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end
    parameter "id",<<-DESC,required: true
    The id of the organization
    DESC
    let "id" do
      persisted_organization.id.to_s
    end
    let "organization_id" do
      persisted_organization.id.to_s
    end
    let "name" do
      "Police"
    end
    example_request "PATCH /v1/organizations/:id" do
      expect(status).to eq 200

      expect(JSON.parse(response_body)["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end
  get "/v1/organizations" do
    before do
      2.times do
        FactoryGirl.create(:organization)
      end
    end

    example_request "GET /v1/organizations" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end
  delete "/v1/organizations/:organization_id" do
    let :persisted_organization do
      FactoryGirl.create(:organization)
    end
    let :organization_id do
      persisted_organization.id.to_s
    end
    example_request "DELETE /v1/users/:id" do
      expect(status).to eq 204
    end
  end
end
