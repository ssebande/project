module V1
  RSpec.describe OrganizationResource do
    let :creatable_fields do
      [:name].sort
    end
    subject do
      described_class.new Organization.new, {}
    end
    it 'has the expected creatable fields' do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end
    it 'has the expected updatable fields' do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields

    end
    it 'has the expected fetchable fields' do
      expect(subject.fetchable_fields.sort).to eq ([:id,:created_at,:updated_at] + creatable_fields).sort
    end
  end
end
