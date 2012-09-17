namespace :db do
  desc "Fill database with sample data"
  task populate_competitions: :environment do 
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
  
  task populate_projects: :environment do
    account = Account.where(profile_type: "Contributor").first
    number = Random.new
    5.times do |n|
      project = account.projects.build
      project.business_name = "Project #{n + 1}"
      project.industry = 'Other'
      project.city = 'New York'
      project.state = 'New York'
      project.business_concept = 'The quick brown fox jumped over the lazy dog. ' * (number.rand(2..6))
      project.logo = File.open("#{Rails.root}/app/assets/images/uga.png")
      project.save!
      project.publish!      
    end        
  end
end

