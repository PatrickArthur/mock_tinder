require "rails_helper"

RSpec.describe Api::MessagesController do
  let!(:conversation) { create(:conversation_with_messages)}
  let!(:user1) { conversation.sender}

  before do
    sign_in user1
  end

  describe "POST#create" do
    it "user creates new message" do
      start_count = conversation.messages.count
      post :create, :params => {conversation_id: conversation.id, message: "hello"}
      expect(response).to be_successful
      message = JSON.parse(response.body)
      expect(message["messages"].last["body"]).to eq("hello")
      expect(conversation.messages.count - start_count).to eq(1)
    end

    it "marks last message to read" do
      unread_message_count = conversation.messages.where(read: true).count
      post :create, :params => {conversation_id: conversation.id, message: "hello"}
      expect(response).to be_successful
      message = JSON.parse(response.body)
      expect(unread_message_count).to_not eq(message["message_count"])
    end
  end
end
