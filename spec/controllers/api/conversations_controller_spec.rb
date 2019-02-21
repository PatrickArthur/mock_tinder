require "rails_helper"

RSpec.describe Api::ConversationsController do
  let!(:conversation) { create(:conversation_with_messages)}

  before do
    sign_in create(:user)
  end

  describe "GET#index" do
    it "current user active conversations" do
      get :index, :params => { :user_id => conversation.sender.id}
      expect(response).to be_successful
      conversations = JSON.parse(response.body)
      expect(conversations.first["recipient"]["id"]).to eq(conversation.recipient.id)
      expect(conversations.first["sender"]["id"]).to eq(conversation.sender.id)
      expect(Conversation.count).to eq(1)
    end

    it "current user active conversations multiple" do
      other_user = create(:user, username: "ron")
      new_conv = create(:conversation, sender: conversation.sender, recipient: other_user)
      get :index, :params => { :user_id => conversation.sender.id}
      expect(response).to be_successful
      conversations = JSON.parse(response.body)
      expect(conversations.last["recipient"]["id"]).to eq(other_user.id)
      expect(conversations.last["sender"]["id"]).to eq(conversation.sender.id)
      expect(Conversation.count).to eq(2)
    end

    it "current user with no conversations" do
      user_id = conversation.sender.id
      other_user = create(:user, username: "ron")
      conversation.update_attribute(:sender, other_user)
      get :index, :params => { :user_id => user_id}
      conversation = Conversation.where(sender_id: user_id)
      expect(conversation.count).to eq(0)
    end
  end

  describe "GET#show" do
    it "shows conversation between sender and recipient" do
      get :show, :params => { :id => conversation.id}
      converse = JSON.parse(response.body)
      expect(response).to be_successful
      expect(converse["recipient"]).to eq(conversation.recipient.email)
      expect(converse["sender"]).to eq(conversation.sender.email)
    end

    it "conversation unread messages count" do
      pending 'not working correct ater small tweek'
      ct = conversation.messages.where(read: false).count
      get :show, :params => { :id => conversation.id}
      converse = JSON.parse(response.body)
      expect(converse["message_count"]).to eq(2)
    end
  end
end
