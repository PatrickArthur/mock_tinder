module Api
  class ActivityFeedController < BaseController
    before_action :authenticate_user!

    def index
      @user = User.find(params[:user_id])
      @voted_pics = @user.pictures.map {|x| {votes: x.votes.map { |z| {picture: x, email: z.user.email, time: z.user.created_at.strftime("Voted on %m/%d/%Y at %I:%M%p")}}}}.select {|n| !n[:votes].empty?}
      json_response(@voted_pics, :ok)
    end
  end
end


