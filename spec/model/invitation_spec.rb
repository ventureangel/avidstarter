require 'spec_helper'

describe Invitation do
  let(:invitation) {FactoryGirl.build(:invitation)}
  
  it {should validate_presence_of :recipient_email}
  it {should validate_presence_of :recipient_name}
  it {should belong_to :project}
  it 'should generate a token after create' do
    invitation.should_receive(:generate_token)
    invitation.save
  end

  it 'should return label' do
    invitation.label.should == "Test Name (test@test.com)"
  end
end
