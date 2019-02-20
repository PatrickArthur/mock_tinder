FactoryBot.define do
  factory :viewed_photo do
    user { create(:user) }
    picture { create(:photo) }
  end
end
