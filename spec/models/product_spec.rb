require 'rails_helper'
RSpec.describe Product do
  [
  "title","description","quantity","aauction_window_ends_at","aauction_window_starts_at","display_description","minimum_bid"
].each do |attribute|
  it {is_expected.to have_attribute attribute}


end
["aauction","seller"].each do |required_relationship|
  it {is_expected.to belong_to required_relationship}
  it {is_expected.to validate_presence_of required_relationship}

end
# it{ is_expected.to belong_to :bid_type}
it 'validates that quantity is either nil or greater than 0' do
  subject.quantity = nil
  subject.valid?
  expect(subject.errors[:quantity]).to be_empty
  subject.quantity= 0
  subject.valid?
  expect(subject.errors[:quantity]).to include "must be greater than 0"
  subject.quantity=1
  subject.valid?
  expect(subject.errors[:quantity]).to be_empty
end
  it 'validates that aauction_window_ends_at is after aauction_window_starts_at' do
    subject.aauction_window_starts_at = DateTime.new(2015,10,10,11,00)
    subject.aauction_window_ends_at = subject.aauction_window_starts_at
    subject.valid?
    expect(subject.errors[:aauction_window_ends_at]).to include "must be greater than aauction_window_starts_at"
    subject.aauction_window_ends_at = subject.aauction_window_starts_at.advance(seconds: 1)
    subject.valid?
    expect(subject.errors[:aauction_window_ends_at]).to be_empty
  end

    it 'validates that minimum_bid is either nil or greater than 0' do
      subject.minimum_bid = nil
      subject.valid?
      expect(subject.errors[:minimum_bid]).to be_empty
      subject.minimum_bid = 0
      subject.valid?
      expect(subject.errors[:minimum_bid]).to include "must be greater than 0"
      subject.minimum_bid = 1
      subject.valid?
      expect(subject.errors[:minimum_bid]).to be_empty
    end
end
