FactoryBot.define do
  factory :player do
    name { Faker::Football.player }
    team
    position { Faker::Football.position }
  end
end
