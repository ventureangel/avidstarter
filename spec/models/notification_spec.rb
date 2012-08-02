require 'spec_helper'

describe Notification do
  it {should validate_presence_of :title}
  it {should validate_presence_of :description}
  it {should validate_presence_of :notifier_id}
  it {should validate_presence_of :notifier_type} 
  it {should validate_presence_of :notification_type} 
  it {should respond_to :notifier}
end
