CarrierWave.configure do |config|
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],        # required
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],        # required
    }
    config.fog_directory  = ENV["S3_BUCKET"]              # required
  end
end
