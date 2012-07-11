require 'spec_helper'

describe Account do
  let(:account) {FactoryGirl.build(:account)}
  
  it 'should have a valid factory' do 
    account.should be_valid
  end
  
  it {should validate_presence_of :email}
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :last_name}
  it {should validate_presence_of :password}

  it {should respond_to(:profile_type)}
  
  it 'should return name' do 
    account.name.should == "#{account.first_name} #{account.last_name}"
  end

  it 'should return label' do
    email = account.email
    account.stub(:name).and_return("Cubert Farnsworth")
    account.label.should == "Cubert Farnsworth (#{email})"
  end

  it 'should determine email' do
    account.should_receive(:determine_email)
    account.confirm!
  end

  it 'should set_profile_type' do
    account.should_receive(:set_profile_type)
    account.confirm!
  end

  it 'should set school email profile type to contributor' do
    contributor = account
    contributor.confirm!
    contributor.profile_type.should == "Contributor"
  end

  it 'should set nonschool email profile type to viewer' do
    viewer = FactoryGirl.build(:viewer)
    viewer.confirm!
    viewer.profile_type.should == "Viewer"
  end

  it 'invited? should be true if account has invitation_token' do
    invited = FactoryGirl.build(:invited_contributor)
    invited.confirm!
    invited.should be_invited
  end

  it 'should call create_memberships_from_invitations if invited is true' do
    account.stub(:invited?).and_return(true)
    account.should_receive(:create_memberships_from_invitations)
    account.confirm!
  end
end
