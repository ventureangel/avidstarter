require 'spec_helper'

describe Membership do
  let(:mail) {stub(deliver: true)}
  it {should belong_to :project}
  it {should belong_to :account}
  it {should validate_presence_of :account}
  let(:membership) {FactoryGirl.build(:membership)}

  it 'should have a valid factory' do
    Membership.stub(:notify_of_invitation)
    membership = FactoryGirl.create(:membership)
    membership.should be_valid
  end 

  it 'should call notify_of_invitation after create' do
    ProjectMembers.stub(:membership_invitation)
    membership.should_receive(:notify_of_invitation)
    membership.save
  end

  it 'should send out an email after inviting current account to project' do
    ProjectMembers.should_receive(:membership_invitation).with(membership).and_return(mail)
    membership.save
  end

  it 'should not send out an email if membership is not pending' do
    membership = FactoryGirl.build(:membership, :pending => false)
    membership.should_not_receive(:notify_of_invitation)
    membership.save
  end

  it 'should delete the project if it is the last member to leave the project' do
    membership.save
    project_id = membership.project.id
    membership.destroy
    Project.where(id: project_id).empty?.should be true
  end

  it 'should not delete a project if it is not the last member' do
    account = FactoryGirl.create(:account)
    membership.save
    project = membership.project
    membership2 = project.memberships.build
    membership2.account = account
    membership2.pending = false
    membership2.save
    project_id = membership.project.id
    membership.destroy
    Project.where(id: project_id).empty?.should be false
  end
end
