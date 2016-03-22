module V1
  class OrganizationResource < BaseResource
    attribute :name
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
