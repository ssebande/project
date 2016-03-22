module V1
  RSpec.describe UserResource do
    let :creatable_fields do
      [:name,:phone_number,:email_address,:physical_address,:password].sort
    end
    subject do
      described_class.new User.new, {}
    end
    it 'has the expected creatable fields' do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end
    it 'has the expected updatable fields' do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields

    end
    it 'has the expected fetchable fields' do
      expect(subject.fetchable_fields.sort).to eq ([:id,:created_at,:updated_at] + creatable_fields - [:password]).sort
    end
  end
end
