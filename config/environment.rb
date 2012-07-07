# Load the rails application
require File.expand_path('../application', __FILE__)

#loads file with s3 keys that are not pushed to git
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

# Initialize the rails application
Avidstarter::Application.initialize!
