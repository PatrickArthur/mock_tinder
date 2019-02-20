module ApplicationHelper
  def vote_likes_process(photo)
    not_viewed = photo.user.pictures - current_user.viewed_pictures

    if not_viewed.present?
      json_response(not_viewed.first, :created)
    else
      user = User.all_except(current_user, photo.user)
      not_viewed = user.pictures - current_user.viewed_pictures
      if not_viewed.present?
        json_response(not_viewed.first, :created)
      else
        json_response(nil, :ok)
      end
    end
  end
end
