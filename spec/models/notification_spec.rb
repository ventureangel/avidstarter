require 'spec_helper'

describe Notification do
  it {should validate_presence_of :title}
  it {should validate_presence_of :description}
  it {should validate_presence_of :notifier_id}
  it {should validate_presence_of :notifier_type} 
  it {should validate_presence_of :notification_type} 
  it {should respond_to :notifier}

  let(:account) {FactoryGirl.create(:account)}
  

  it 'should not allow events to be created without a date' do 
    notification = FactoryGirl.build(:notification, :notifier => account, :notification_type => 'Event')
    notification.should_not be_valid    
  end

  it 'should not allow non-events to be created with a date' do
    notification = FactoryGirl.build(:recruiting, :notifier => account, :date => DateTime.now)
    notification.should_not be_valid
  end

  it 'should be set as a priority if admin is creating it' do
    account.profile_type = 'Admin'
    notification = FactoryGirl.create(:announcement, :notifier => account)
    notification.priority.should be true
  end
end
