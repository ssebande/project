FactoryGirl.define do
  factory :user do
    name "sseebandeke"
    password "jesus103"
    sequence(:email_address){|n| "test-#{n}example.com"}
    physical_address "kampala"
    sequence(:phone_number){|n| "+34767833#{n}"}
  end
end
