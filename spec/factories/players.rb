FactoryBot.define do
  factory :player do
    first_name { "Ma" }
    last_name { "Long" }
    rating { 9000 }
    handedness { "right" }
  end
  factory :player_two, class: Player do
    first_name { "Timo" }
    last_name { "Boll" }
    rating { 8000 }
    handedness { "right" }
  end
end
