class UpdateViewedPicturesJob < ApplicationJob
  queue_as :default

  def perform
    photos = ViewedPhoto.all
    photos.each do |photo|
      time = Time.now
      hours = (time - photo.created_at) / 1.hour
      if hours >= 6
        photo.update_attribute(viewed_at: nil)
      end
    end
  end
end
