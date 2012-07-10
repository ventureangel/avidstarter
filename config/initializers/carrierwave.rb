CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET']
  }
  config.fog_directory  = 'avidstarter-dev'
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
class MyUploader < CarrierWave::Uploader::Base
  storage :fog
end
