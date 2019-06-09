FactoryBot.define do
  factory :team do
    name { Faker::WorldCup.team }
  end
end
