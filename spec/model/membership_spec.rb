require 'spec_helper'

describe Membership do
  let(:mail) {stub(deliver: true)}
  it {should belong_to :project}
  it {should belong_to :account}
  it {should validate_presence_of :account}
  it {should validate_presence_of :project}

  it 'should have a valid factory' do
    Membership.stub(:notify_of_invitation)
    membership = FactoryGirl.create(:membership)
    membership.should be_valid
  end 

  it 'should call notify_of_invitation after create' do
    ProjectMembers.stub(:membership_invitation)
    membership = FactoryGirl.build(:membership)
    membership.should_receive(:notify_of_invitation)
    membership.save
  end

  it 'should send out an email after inviting current account to project' do
    membership = FactoryGirl.build(:membership)
    ProjectMembers.should_receive(:membership_invitation).with(membership).and_return(mail)
    membership.save
  end

  it 'should not send out an email if membership is not pending' do
    membership = FactoryGirl.build(:membership, :pending => false)
    membership.should_not_receive(:notify_of_invitation)
    membership.save
  end

end
