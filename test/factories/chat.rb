FactoryBot.define do
  factory :chat do
    organization
    initiated_on { Date.today }
    initiated_by { create :user, organization: organization }

    after :create do |chat|
      chat.participants.create user: chat.initiated_by
    end

    trait :with_pets do
      after :build do |chat|
        chat.chat_pets.build(pet: create(:pet, organization: chat.organization))
      end
    end

    trait :with_participants do
      transient do
        participant_count { 1 }
      end

      after :create do |chat, context|
        context.participant_count.times do
          chat.participants.create! user: create(:user, organization: chat.organization)
        end
      end
    end

    trait :with_messages do
      transient do
        message_count { 10 }
      end

      after :create do |chat, context|
        create_list(:message, context.message_count, chat: chat)
      end
    end
  end

  factory :message, class: "Chat::Message" do
    chat
    content { Faker::Lorem.sentence }
    author { chat.participants.sample.user }
  end
end
