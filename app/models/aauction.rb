class Aauction < ActiveRecord::Base
  validate :_ends_at_after_starts_at
 validate :_starts_at_after_product_window_ends_at
	validates :time_zone_id, inclusion: {in: ActiveSupport::TimeZone.all.map{|tz| tz.tzinfo.identifier}}, allow_blank: true
validates :organization,presence: true
 belongs_to :organization
 # has_many :products

 def _ends_at_after_starts_at
   return unless starts_at && ends_at
   if ends_at <= starts_at
     errors.add :ends_at, "must be greater than starts_at"
   end
 end
 def _starts_at_after_product_window_ends_at
   return unless product_window_ends_at && starts_at
   if starts_at <= product_window_ends_at
     errors.add :starts_at,"must be greater than product_window_ends_at"
   end
 end
end
