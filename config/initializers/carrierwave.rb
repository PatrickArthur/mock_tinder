CarrierWave.configure do |config|
  CarrierWave.configure do |config|
    if Rails.env.development? || Rails.env.test?
      config.storage = :file
      config.enable_processing = false
      config.root = "#{Rails.root}/tmp"
    else
      config.fog_provider = 'fog/aws'                        # required
      config.fog_credentials = {
        provider:              'AWS',                        # required
        aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],        # required
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],        # required
      }
      config.fog_directory  = ENV["S3_BUCKET"]              # required
    end
  end
end
