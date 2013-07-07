# -*- coding: utf-8 -*-
require 'twitter'

namespace :tweet do
  SHOP_ID = 1 # 夕花
  desc "tweet todays's message"
  task :yuka => :environment do
    Twitter.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY'] || CONFIG["twitter_app"]["consumer_key"]
      config.consumer_secret    = ENV['CONSUMER_SECRET'] || CONFIG["twitter_app"]["consumer_secret"]
      config.oauth_token        = ENV['OAUTH_TOKEN'] || CONFIG["tweet_user"]["oauth_token"]
      config.oauth_token_secret = ENV['OAUTH_SECRET'] || CONFIG["tweet_user"]["oauth_secret"]
    end
    Tweet.tweet_todays_message(SHOP_ID)
  end
end
