module Response
  def vote_likes_process
    picture = Picture.get_picture(current_user)
    if picture.present?
      json_response(picture, :created)
    else
      json_response(nil, :ok)
    end
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
