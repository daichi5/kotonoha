# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'mini_racer'
gem 'pg'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'
# CSSフレームワーク
gem 'bootstrap', '~> 4.3.1'
# テンプレートエンジン
gem 'slim'
# 検索フォーム
gem 'jquery-rails'
gem 'ransack'
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
gem 'aws-sdk-s3', require: false
gem 'mini_magick'
# seedデータ生成用
gem 'faker'
# AssetsのCDN配信（S3オリジン)
gem 'asset_sync'
gem "fog-aws"
# 個別投稿アクセス数取得とランキング取得
gem 'redis', '~> 4.0'
# ログイン認証
gem 'devise', '~> 4.6.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'capybara-email', '~> 3.0.1'
  gem 'factory_bot_rails', '~> 4.11'
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
