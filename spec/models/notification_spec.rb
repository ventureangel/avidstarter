require 'spec_helper'

describe Notification do
  it {should validate_presence_of :title}
  it {should validate_presence_of :description}
  it {should validate_presence_of :notifier_id}
  it {should validate_presence_of :notifier_type} 
  it {should belong_to :notifier}
end
