FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    complete { false }
    exam_id nil
  end
end