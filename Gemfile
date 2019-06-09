source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'rails', '~> 5.2.2'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'mini_racer'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# CSSフレームワーク
gem 'bootstrap', '~> 4.3.1'
# テンプレートエンジン
gem 'slim'
# 検索フォーム
gem 'ransack'
gem 'jquery-rails'
# タグ付け機能
gem 'acts-as-taggable-on', '~> 6.0'
# ページネーション
gem 'kaminari'
# チャート描画
gem 'chart-js-rails'
gem 'gon'
# パンくずリスト
gem 'gretel'
# ActiveStorage
gem 'mini_magick'
gem 'aws-sdk-s3', require: false
# seedデータ生成用
gem 'faker'
# AssetsのCDN配信（S3オリジン)
gem 'asset_sync'
gem "fog-aws"
# 個別投稿アクセス数取得とランキング取得
gem 'redis', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec_junit_formatter'
  gem 'factory_bot_rails', '~> 4.11'
end

