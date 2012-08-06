require 'spec_helper'

describe Project do
  
  it {should validate_presence_of :business_name}
  it {should validate_presence_of :industry}
  it {should validate_presence_of :city}
  it {should validate_presence_of :state}
  it {should validate_presence_of :business_concept}
  it {should respond_to :logo}
  it {should respond_to :memberships}
  it {should respond_to :members}
  it {should respond_to :confirmed_memberships}
  it {should respond_to :pending_memberships}
  it {should respond_to :invitations}
 
  it {should respond_to(:notifications)}

  it {should have_many(:members).through(:confirmed_memberships)}
  it {should have_many(:attachments)}
  
  let(:project) {FactoryGirl.create(:project)}

  it 'should have a valid factory' do
    project.should be_valid
  end 

  it 'should not be publishable if it is incomplete' do
    project.publish!
    project.published.should be false
  end

  it 'should be publishable' do
    project.publish!
    project.published.should be true 
  end
end
