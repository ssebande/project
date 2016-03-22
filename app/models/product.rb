class Product < ActiveRecord::Base
  belongs_to :aauction
  # belongs_to :bid_type
  belongs_to :seller,class_name: "User"

  validates :seller, presence: true
  validates :aauction, presence: true
  validates :quantity, numericality: { greater_than: 0}, allow_nil: true
  validates :minimum_bid, numericality: { greater_than: 0}, allow_nil: true
  validate :aauction_window_ends_at_greater_than_aauction_window_starts_at

  def aauction_window_ends_at_greater_than_aauction_window_starts_at
    return unless aauction_window_ends_at && aauction_window_starts_at
      if aauction_window_ends_at <= aauction_window_starts_at
        errors.add :aauction_window_ends_at, "must be greater than aauction_window_starts_at"

      end
  end
end
