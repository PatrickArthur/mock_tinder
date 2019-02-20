module Api
  class MessagesController < BaseController
    before_action :authenticate_user!

    def create
      @message = Message.new(user_id: current_user.id,
                             conversation_id: params[:conversation_id],
                             body: params[:message])
      if @message.save
        json_response(@message.conversation.find_messages, :created)
      else
        json_response("message not created", :error)
      end
    end
  end
end
