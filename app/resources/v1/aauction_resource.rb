module V1
  class AauctionResource < BaseResource
    attribute :starts_at
    attribute :ends_at
    attribute :time_zone_id
    attribute :physical_address
    attribute :product_window_ends_at
    attribute :name

    has_one :organization
    # has_many :products
  end
  class << self
    def creatable_fields
      super - [:organization]
    end
    alias_method :updatable_fields, :creatable_fields
  end

end
