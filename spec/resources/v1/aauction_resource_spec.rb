module V1
  RSpec.describe AauctionResource do
    let :creatable_fields do
      [:starts_at,:ends_at,:time_zone_id,:physical_address,:product_window_ends_at,:name].sort
    end
    subject do
      described_class.new Aauction.new, {}
    end
    it 'has the expected creatable fields' do
      expect(described_class.creatable_fields({}).sort).to eq ([:organization] + creatable_fields).sort
    end
    it 'has the expected updatable fields' do
      expect(described_class.updatable_fields({}).sort).to eq ([:organization] + creatable_fields).sort

    end
    it 'has the expected fetchable fields' do
      expect(subject.fetchable_fields.sort).to eq ([:organization,:id] + creatable_fields + [:created_at,:updated_at]).sort
    end
  end

end
