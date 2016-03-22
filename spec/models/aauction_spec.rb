require 'rails_helper'
RSpec.describe Aauction do
    describe 'attributes ' do
      it { is_expected.to have_attribute :starts_at}
      it { is_expected.to have_attribute :ends_at}
      it { is_expected.to have_attribute :name}
      it { is_expected.to have_attribute :physical_address}
      it { is_expected.to have_attribute :product_window_ends_at}
      it { is_expected.to have_attribute :time_zone_id}

    end
    it {is_expected.to belong_to :organization}

  describe 'validations ' do
      it {is_expected.to validate_presence_of :organization}
      it 'ends_at is after starts_at' do
        subject.ends_at= DateTime.new(2015,10,1,0,0)
        subject.starts_at=subject.ends_at.advance(seconds: 1)
        subject.valid?
        expect(subject.errors[:ends_at]).to include "must be greater than starts_at"
      end
      it 'starts_at is after product_window_ends_at' do
        subject.starts_at= DateTime.new(2015,10,1,0,0)
        subject.product_window_ends_at=subject.starts_at.advance(seconds: 1)
        subject.valid?
        expect(subject.errors[:starts_at]).to include "must be greater than product_window_ends_at"
      end
      it 'has a valid factory' do
        expect(FactoryGirl.create(:aauction)).to be_persisted
      end
      it 'time_zone_id is a valid time_zone_id' do
        subject.time_zone_id = "MarsTime"
        subject.valid?
        expect(subject.errors[:time_zone_id]).to include "is not included in the list"
      end
      it 'time_zone_id cant be blank' do
        subject.time_zone_id = nil
        subject.valid?
        expect(subject.errors[:time_zone_id]).to be_empty
      end
    end
end
