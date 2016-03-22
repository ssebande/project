require 'rails_helper'
RSpec.describe User do
  ["name","phone_number","email_address","physical_address"].each do |required_attribute|
   it {is_expected.to have_attribute required_attribute}
   it {is_expected.to validate_presence_of required_attribute }
 end
 it {is_expected.to validate_presence_of :password}
 # it {is_expected.to have_many :memberships}
 # it {is_expected.to have_many :organisations}
 it 'validates the uniqueness of phone_number' do
   original = FactoryGirl.create(:user)
   duplicate = FactoryGirl.build(:user,phone_number: original.phone_number)
   duplicate.valid?
   expect(duplicate.errors[:phone_number]).to include "has already been taken"
 end
 it 'validates the uniqueness of email_address' do
   original = FactoryGirl.create(:user)
   duplicate = FactoryGirl.build(:user,email_address: original.email_address)
   duplicate.valid?
   expect(duplicate.errors[:email_address]).to include "has already been taken"
 end
 it 'persists a password digest based on oauth used for authentication'do
  password = "password"
    subject = FactoryGirl.create(:user, password: password)

    expect(subject.authenticate(password)).to eq subject
  end
end
