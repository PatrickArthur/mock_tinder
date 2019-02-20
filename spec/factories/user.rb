FactoryBot.define do
  factory :user do
    username { 'John' }
    sequence(:email, 1000) { |n| "person#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    factory :user_with_pictures do
      after(:create) do |user|
        picture1 = create(:picture)
        user.pictures << picture1
        user.save
      end
    end
  end
end
