class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def show
    @conversation_id = params[:id]
  end
end
