FactoryBot.define do
  factory :message do
    user { create(:user, username: "Kazmer") }
    conversation { create(:conversation, sender: user) }
    body {"derp"}
    read { false }
  end
end
