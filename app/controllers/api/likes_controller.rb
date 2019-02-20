module Api
  class LikesController < BaseController
    before_action :authenticate_user!

    def create
      @like = Like.create(user: current_user,
                          picture_id: params[:picture_id],
                          like_object: params[:like_object])

      vote_likes_process(@like.picture)
    end
  end
end
