module Api
  class UsersController < BaseController
    before_action :authenticate_user!

    def show
      @user = User.find(params[:id])
      if @user
        user_data = {
          user: @user,
          pictures: @user.pictures.each_slice(3).to_a
        }
        json_response(user_data, :ok)
      else
        json_response({}, :error)
      end
    end

    def update
    end
  end
end
