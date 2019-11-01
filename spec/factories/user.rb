FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '12345678' }
    password_confirmation { '12345678' }
    name { Faker::Games::SonicTheHedgehog.character }
    last_seen { Faker::Time.between(from: DateTime.now - 6.weeks, to: DateTime.now + 6.weeks) }
    sex { Faker::Gender.type }
    age { Faker::Number.between(from: 1, to: 107) }

    postcode 
  end

  factory :student, parent: :user, class: 'Student' do
  end

  factory :tutor, parent: :user, class: 'Tutor' do
    max_distance_available { Faker::Number.between(from: 1, to: 500) }
    hourly_rate { Faker::Number.between(from: 1, to: 100) }
    biography { Faker::Hipster.paragraph }
  end
end
