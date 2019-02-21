require "rails_helper"

RSpec.describe Api::LikesController do
  let!(:current_user) { create(:user)}
  let!(:photo_user) { create(:user)}
  let!(:picture) { create(:picture, user: photo_user)}
  let!(:picture2) { create(:picture, user: current_user)}
  let!(:picture3) { create(:picture, user: photo_user)}

  before do
    sign_in current_user
  end

  describe "POST#create" do
    context 'current user likes photo' do
      it "likes photo, creates conversation" do
        post :create, :params => { :user_id => current_user.id, :like_object => true , :picture_id => picture.id}
        expect(response).to be_successful
        expect(Like.count).to eq(1)
        expect(current_user.disliked.count).to eq(0)
        expect(current_user.liked.count).to eq(1)
        expect(Conversation.count).to eq(1)
        next_pic = JSON.parse(response.body)
        expect(next_pic["id"]).to eq(picture3.id)
      end
    end

    context 'current user dislikes photo' do
      it "dislikes photo, no conversation should be create" do
        post :create, :params => { :user_id => current_user.id, :like_object => false , :picture_id => picture2.id}
        expect(response).to be_successful
        expect(Like.count).to eq(1)
        expect(current_user.disliked.count).to eq(1)
        expect(current_user.liked.count).to eq(0)
        next_pic = JSON.parse(response.body)
        expect(next_pic["id"]).to eq(picture.id)
      end
    end
  end
end

