CarrierWave.configure do |config|
  if Rails.env.development? or Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET']
    }
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.storage = :fog
    config.fog_directory = 'avidstarter-dev' if Rails.env.development?
    config.fog_directory = 'avidstarter-production' if Rails.env.production?
  else
    config.storage = :file
  end
end
