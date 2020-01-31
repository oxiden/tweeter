# -*- coding: utf-8 -*-
require 'twitter'

namespace :tweet do
  desc "tweet todays's message"
  task :yuka => :environment do
    SHOP_ID = 1 # 夕花
    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY'] || CONFIG["twitter_app"]["consumer_key"]
      config.consumer_secret     = ENV['CONSUMER_SECRET'] || CONFIG["twitter_app"]["consumer_secret"]
      config.access_token        = ENV['OAUTH_TOKEN'] || CONFIG["tweet_user"]["oauth_token"]
      config.access_token_secret = ENV['OAUTH_SECRET'] || CONFIG["tweet_user"]["oauth_secret"]
    end
    Tweet.tweet_todays_message(twitter, SHOP_ID)
    Tweet.tweet_mentions(twitter, SHOP_ID)
  end
end
