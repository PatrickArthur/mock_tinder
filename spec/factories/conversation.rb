FactoryBot.define do
  factory :conversation do
    sender { create(:user) }
    recipient { create(:user, username: "Kazmer") }

    factory :conversation_with_messages do
      after(:create) do |conversation|
        message1 = create(:message, conversation: conversation, user: conversation.sender)
        message2 = create(:message, conversation: conversation, user: conversation.recipient)
        conversation.messages << message1
        conversation.messages << message2
        conversation.save
      end
    end
  end
end
