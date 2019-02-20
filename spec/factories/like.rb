FactoryBot.define do
  factory :like do
    user { create(:user) }
    picture { create(:photo) }
    like_object { true }
  end
end
