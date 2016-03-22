module V1
  class UserResource < BaseResource
    attribute :name
    attribute :phone_number
    attribute :email_address
    attribute :physical_address
    attribute :password


    class << self
      def creatable_fields(context)
        super 
      end
      alias_method :updatable_fields, :creatable_fields
    end
    def fetchable_fields
      super - [:password]
    end
  end
end
