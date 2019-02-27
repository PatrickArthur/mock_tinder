module Api
  class ActivityFeedController < BaseController
    before_action :authenticate_user!

    def index
      @user = User.find(params[:user_id])
      @voted_pics = @user.votes_json
      if @voted_pics.first.nil? || @voted_pics.empty?
        json_response(nil, :ok)
      else
        json_response(@voted_pics, :ok)
      end
    end
  end
end


