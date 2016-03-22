module V1
  class ProductResource < BaseResource
    has_one :seller
    has_one :aauction
    attribute :title
    attribute :description
    attribute :quantity
    attribute :aauction_window_ends_at
    attribute :aauction_window_starts_at
    attribute :display_description
    attribute :minimum_bid

    class << self
      def creatable_fields(context)
        super
      end
      alias_method :updatable_fields, :creatable_fields
    end
    def fetchable_fields
      super
    end

  end
end
