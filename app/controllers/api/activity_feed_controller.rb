module Api
  class ActivityFeedController < BaseController
    before_action :authenticate_user!

    def index
      @user = User.find(params[:user_id])
      json_response(@user.activity_feed, :ok)
    end
  end
end



