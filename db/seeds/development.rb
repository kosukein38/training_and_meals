#筋トレ部位のデータ
body_part_names = [ "胸", "肩", "背中", "腕", "脚"]
body_part_names.each do |body_part_name|
  BodyPart.create!(body_part_name: body_part_name)
end

# メインのサンプルユーザー
User.create!(
  name:  "FirstUser",
  email: "example@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  introduction: "はじめまして、頑張って大きくなります！",
  height: 163.5,
  body_weight:  85,
  age: 32,
  sex: 'male',
  active_level: 'level1',
  target_weight: 90,
  target_date: "#{Time.now}",
  twitter_link: 'https://twitter.example.com',
  facebook_link: 'https://facebook.example.com',
  instagram_link: 'https://instagram.example.com'
)

# 19ユーザーをまとめて生成
19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+2}@examle.com"
  password = 'password'
  password_confirmation = 'password'
  introduction = Faker::Lorem.sentence
  height = n + 170
  body_weight = n + 70
  age = n + 20
  sex = 'male'
  active_level = 'level1'
  target_weight = 80
  target_date = Time.now + 24 * 60 * 60 * n
  twitter_link = "https://twitter-#{n+2}.example.com"
  facebook_link = "https://facebook-#{n+2}.example.com"
  instagram_link = "https://instagram-#{n+2}.example.com"

  User.create!(
    name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    introduction: introduction,
    height: height,
    body_weight: body_weight,
    age: age,
    sex: sex,
    active_level: active_level,
    target_weight: target_weight,
    target_date: target_date,
    twitter_link: twitter_link,
    facebook_link: facebook_link,
    instagram_link: instagram_link
  )
end

#筋トレ投稿の作成
20.times do |n|
  first_user = User.first
  user = User.offset(rand(User.count)).first
  workout_date = Time.now + 24 * 60 * 60 * n
  workout_title = "筋トレ-#{n}"
  workout_time = 30
  workout_weight = 60 + 10 * n
  repetition_count = 10
  set_count = 3
  workout_memo = Faker::Lorem.sentence
  body_part = BodyPart.offset(rand(BodyPart.count)).first

  Workout.create!(
    user: first_user,
    workout_date: workout_date,
    workout_title: workout_title,
    workout_time: workout_time,
    workout_weight: workout_weight,
    repetition_count: repetition_count,
    set_count: set_count,
    workout_memo: workout_memo
  ).workout_body_parts.build(
    body_part: body_part
  ).save!

  Workout.create!(
    user: user,
    workout_date: workout_date,
    workout_title: workout_title,
    workout_time: workout_time,
    workout_weight: workout_weight,
    repetition_count: repetition_count,
    set_count: set_count,
    workout_memo: workout_memo
  ).workout_body_parts.build(
    body_part: body_part
  ).save!
end

#食事投稿の作成
20.times do |n|
  first_user = User.first
  user = User.offset(rand(User.count)).first
  meal_date = Time.now + 24 * 60 * 60 * n
  meal_period = 'lunch'
  meal_type = 'eating_out'
  meal_memo = Faker::Lorem.sentence
  meal_title = Faker::Food.dish
  meal_weight = (n + 1) * 20
  meal_calorie = (n + 1) * 30

  Meal.create!(
    user: first_user,
    meal_date: meal_date,
    meal_period: meal_period,
    meal_type: meal_type,
    meal_memo: meal_memo
  ).meal_details.build(
    meal_title: meal_title,
    meal_weight: meal_weight,
    meal_calorie: meal_calorie
  ).save!

  Meal.create!(
    user: user,
    meal_date: meal_date,
    meal_period: meal_period,
    meal_type: meal_type,
    meal_memo: meal_memo
  ).meal_details.build(
    meal_title: meal_title,
    meal_weight: meal_weight,
    meal_calorie: meal_calorie
  ).save!
end

