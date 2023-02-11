source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
# gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
# gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
gem 'sassc-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

# 権限管理
gem 'cancancan'

# 環境別の定数管理
gem 'config'

# cssのバンドル・処理
gem 'cssbundling-rails'

# enumで定義した値をi18n化
gem 'enum_help'

# JSのバンドル・処理
gem 'jsbundling-rails'

# ページネーション
gem 'kaminari'

# OGP, メタタグの設定
gem 'meta-tags'

# 管理画面
gem 'rails_admin', '~> 3.0'

# i18n対応
gem 'rails-i18n', '~> 7.0.0'

# カレンダー機能
gem 'simple_calendar', '~> 2.4'

# サイトマップの作成
gem 'sitemap_generator'

# 登録、ログイン
gem 'sorcery'

group :production do
  # Amazon S3を使用するためのパッケージ
  gem 'aws-sdk-s3', require: false
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # デバッグツール
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # テスト用データの作成
  gem 'factory_bot_rails'
  # テスティングフレームワーク
  gem 'rspec-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  # ブラウザ上でのデバッグツール
  gem 'web-console'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  # ダミーデータの作成
  gem 'faker'
  # 開発環境でのメール受信
  gem 'letter_opener_web', '~> 2.0'
  # Lintツール
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  # Webアプリ操作のシミュレート
  gem 'capybara'
  # Webドライバの自動インストールやアップデート
  gem 'webdrivers'
end
