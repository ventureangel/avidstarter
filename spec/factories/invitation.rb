FactoryGirl.define do

  factory :invitation do
    recipient_email 'test@test.com'
    recipient_name 'Test Name'
    association :project
  end

end
