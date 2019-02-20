require "rails_helper"

RSpec.describe Api::PicturesController do
  let!(:user) { create(:user)}
  let!(:file) {fixture_file_upload('ragnar.jpeg', 'image/jpeg')}
  let!(:file2) {fixture_file_upload('ragnar.jpeg', 'image/jpeg')}

  before do
    sign_in user
  end

  describe "POST#create" do
    it "user uploads one photo" do
      post :create, :params => { :user_id => user.id, :uploads => [file]}
      expect(user.pictures.count).to eq(1)
      expect(response).to be_successful
    end

    it "user uploads multiple photo" do
      post :create, :params => { :user_id => user.id, :uploads => [file, file2]}
      expect(user.pictures.count).to eq(2)
      expect(response).to be_successful
    end

    it "user uploads without attachments" do
      post :create, :params => { :user_id => user.id, :uploads => []}
      expect(user.pictures.count).to eq(0)
      expect(response.code).to eq("400")
    end
  end

  describe "GET#show" do
    it "user views photo" do
      user = create(:user_with_pictures)
      post :show, :params => { :user_id => user.id, :id => user.pictures.first.id}
      expect(response).to be_successful
      picture = JSON.parse(response.body)
    end

    it "user doesn't view photo" do
      user = create(:user_with_pictures)
      post :show, :params => { :user_id => user.id, :id => 10}
      expect(response.code).to eq("400")
      expect(response.message).to eq("Bad Request")
    end
  end
end
