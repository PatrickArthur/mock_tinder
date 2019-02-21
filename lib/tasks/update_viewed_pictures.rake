desc 'update viewed photos to false every 6 hours'

task :update_viewed_pictures => :environment do
  UpdateViewedPicturesJob.perform_later
end
