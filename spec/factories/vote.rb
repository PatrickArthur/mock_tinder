FactoryBot.define do
  factory :vote do
    user { create(:user) }
    picture { create(:photo) }
    vote { true }
  end
end
