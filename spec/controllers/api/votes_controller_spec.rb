require "rails_helper"

RSpec.describe Api::VotesController do
  let!(:current_user) { create(:user)}
  let!(:photo_user) { create(:user)}
  let!(:picture) { create(:picture, user: photo_user)}
  let!(:picture2) { create(:picture, user: photo_user)}

  before do
    sign_in current_user
  end

  describe "POST#create" do
    it "current user votes on users photo, goes to users next photo" do
      post :create, :params => { :user_id => current_user.id, :picture_id => picture.id}
      expect(response).to be_successful
      next_picture = JSON.parse(response.body)
      expect(next_picture["id"]).to_not eq(picture.id)
      expect(next_picture["user_id"]).to eq(picture.user_id)
    end
  end
end

