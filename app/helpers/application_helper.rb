module ApplicationHelper
  def vote_likes_process
    user = User.where.not(id: current_user.id).joins(:pictures).sample
    if user || user.pictures.present?
      not_viewed = user.pictures - current_user.viewed_pictures
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

[1]
[2]
