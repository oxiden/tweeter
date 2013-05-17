# -*- coding: utf-8 -*-
require 'twitter'

namespace :tweet do
  CONFIG = YAML.load_file(Pathname(Rails.root) + "config/settings.yml")
  desc "tweet todays's message"
  task :yuka => :environment do
    Twitter.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY'] || CONFIG["twitter_app"]["consumer_key"]
      config.consumer_secret    = ENV['CONSUMER_SECRET'] || CONFIG["twitter_app"]["consumer_secret"]
      config.oauth_token        = ENV['OAUTH_TOKEN'] || CONFIG["tweet_user"]["oauth_token"]
      config.oauth_token_secret = ENV['OAUTH_SECRET'] || CONFIG["tweet_user"]["oauth_secret"]
    end
    tweet_todays_message
  end

  def tweet_todays_message
    menu = CONFIG["menu"][Date.today]
    if menu
      message = ["今日の日替定食は #{menu} です。"]
      message << CONFIG["messages"][Date.today]
      random_comments = CONFIG["random_comments"]
      message << random_comments[rand(random_comments.length * 2)]
      Twitter.update(message.compact.join("\n")[0, 140])
    end
  end
end
