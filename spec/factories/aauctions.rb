FactoryGirl.define do
  factory :aauction do
    association :organization, strategy: :build
   starts_at "2016-01-29 20:09:55"
   ends_at "2016-01-29 21:09:55"
   physical_address "kampala"
   name "lets bet"
   product_window_ends_at "2016-01-28 20:09:55"
   time_zone_id "America/New_York"
  end
end
