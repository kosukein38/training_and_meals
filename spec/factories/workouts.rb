FactoryBot.define do
  factory :workout do
    workout_date { "2022-12-18 14:33:52" }
    workout_title { "MyString" }
    workout_time { 1 }
    workout_weight { 1.5 }
    repetition_count { 1 }
    set_count { 1 }
    workout_memo { "MyText" }
    user { nil }
  end
end
