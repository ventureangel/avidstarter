# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    title "MyString"
    description "MyText"
    notifier_type 'Account'
    factory :event do
      notification_type "Event"
      date DateTime.now
    end

    factory :recruiting do 
      notification_type "Recruiting"
    end
  
    factory :announcement do
      notification_type "Announcement"
    end
  end
end
