module Api
  class ConversationsController < BaseController
    before_action :authenticate_user!

    def index
      @conversations = Conversation.find_json(params[:user_id])
      json_response(@conversations, :created)
    end

    def show
      @conversation = Conversation.find(params[:id])
      if @conversation.present?
        last_message = @conversation.messages.last
        last_message.update_attribute(:read, true)
        json_response(@conversation.find_messages, :created)
      else
        json_response("no active conversations", :not_found)
      end
    end
  end
end
