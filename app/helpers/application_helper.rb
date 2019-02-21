module ApplicationHelper
  def vote_likes_process(photo)
    not_viewed = photo.user.pictures.where(viewed_at: nil)

    if not_viewed.present?
      json_response(not_viewed.first, :created)
    else
      user = User.all_except(current_user, photo.user)
      if user
        not_viewed = user.pictures.where(viewed_at: nil)
        if not_viewed.present?
          json_response(not_viewed.first, :created)
        else
          json_response(nil, :ok)
        end
      else
        json_response(nil, :ok)
      end
    end
  end
end
