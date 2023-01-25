SitemapGenerator::Sitemap.default_host = "https://bulk-upper.com/"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{Rails.application.credentials.aws[:s3][:bucket]}"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  Rails.application.credentials.aws[:s3][:bucket],
  aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
  aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
  aws_region: Rails.application.credentials.aws[:s3][:region]
)
SitemapGenerator::Sitemap.create do
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  # 利用規約
  add terms_path
  # プライバシーポリシー
  add privacy_path
  # 問い合わせ
  add contact_path
  # ログインページ
  add login_path
  # ユーザー登録ページ
  add new_user_path
  # ユーザー詳細ページ（マイページ）
  User.find_each do |user|
    add user_path(user), :priority => 0.7, :changefreq => 'daily'
  end
  # 筋トレ投稿一覧
  add workouts_path, :priority => 0.7, :changefreq => 'daily'
  # 筋トレ投稿詳細ページ
  Workout.find_each do |workout|
    add workout_path(workout), :priority => 0.7, :lastmod => workout.updated_at
  end
  # 食事投稿一覧
  add meals_path, :priority => 0.7, :changefreq => 'daily'
  # 食事投稿詳細ページ
  Meal.find_each do |meal|
    add meal_path(meal), :priority => 0.7, :lastmod => meal.updated_at
  end
end
