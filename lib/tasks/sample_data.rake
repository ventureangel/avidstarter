namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do 
    100.times do |n|
      name = "Competition: #{n+1}"
      date = Time.now + n.days
      time = date
      city = "Athens"
      state = "Georgia"
      location = "Sanford Hall"
      accepting_business_plans = true
      prize = "$10,000"
      competition_details = "Business plan competition!"
      requirements = "Must be a UGA student"
      additional_info = "Must submit plan through avidstarter"
      
      Competition.create!(competition_name: name, 
                          date: date, 
                          time: time, 
                          city: city, 
                          state: state, 
                          location: location, 
                          accepting_business_plans: true, 
                          prize: prize, 
                          competition_details: competition_details, 
                          requirements: requirements, 
                          additional_info: additional_info)
    end
  end
end

