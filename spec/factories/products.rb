FactoryGirl.define do
  factory :product do
    title "samsung"
    description "very lovely phone"
    quantity 1
    association :aauction,strategy: :build
    association :seller,factory: :user ,strategy: :build
    # association :bid_type,strategy: :build

    aauction_window_starts_at "2016-02-04 02:27:24"
    aauction_window_ends_at "2016-02-04 03:27:24"
    minimum_bid 1000
    display_description "video"
  end
end
