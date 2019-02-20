module Api
  class PicturesController < BaseController
    before_action :authenticate_user!

    def index
      picture = Picture.get_picture(current_user)
      json_response(picture, :ok)
    end

    def create
      pictures = []
      if params[:uploads].present?
        params[:uploads].each do |upload|
          picture = Picture.new(user_id: params[:user_id], file: upload)
          pictures << picture unless !picture.save
        end
        if pictures.count == params[:uploads].count
          user_data = {
            user: current_user,
            pictures: current_user.pictures.each_slice(3).to_a
          }

          json_response(user_data, :created)
        else
          json_response({}, :error)
        end
      else
        json_response({}, :bad_request)
      end
    end

    def show
      @picture = Picture.where(user_id: params[:user_id], id: params[:id]).last
      if @picture.present?
        json_response(@picture,   :ok)
      else
        json_response({}, :bad_request)
      end
    end
  end
end
