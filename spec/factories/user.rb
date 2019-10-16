FactoryBot.define do
  factory :user do
    last_online_at { Faker::Time.between(from: DateTime.now - 6.weeks, to: DateTime.now + 6.weeks) }
    sex
    age
    postcode
  end

  factory :student, parent: :user, class: 'Student' do
  end

  factory :tutor, parent: :user, class: 'Tutor' do
    max_distance_available { Faker::Number.between(from: 1, to: 500) }
    hourly_rate { Faker::Number.between(from: 1, to: 100) }
    availability
    biography
  end
end
