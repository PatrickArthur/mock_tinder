module Api
  class VotesController < BaseController
    before_action :authenticate_user!

    def create
      @vote = Vote.create(user: current_user,
                          picture_id: params[:picture_id],
                          vote: true)

      vote_likes_process
    end
  end
end
