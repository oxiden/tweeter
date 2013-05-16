# -*- coding: utf-8 -*-
require 'twitter'

namespace :tweet do
  CONFIG = YAML.load_file(Pathname(Rails.root) + "config/settings.yml")
  desc "tweet todays's message"
  task :yuka => :environment do
    Twitter.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY'] || CONFIG["twitter_app"]["consumer_key"] || ""
      config.consumer_secret    = ENV['CONSUMER_SECRET'] || CONFIG["twitter_app"]["consumer_secret"] || ""
      config.oauth_token        = ENV['OAUTH_TOKEN'] || CONFIG["tweet_user"]["oauth_token"] || ""
      config.oauth_token_secret = ENV['OAUTH_SECRET'] || CONFIG["tweet_user"]["oauth_secret"] || ""
    end
    Twitter.update(todays_message)
  end

  def todays_message
    message = ["今日の日替わりランチは #{CONFIG["menu"][Date.today]} です。"]
    message << CONFIG["messages"][Date.today]
    random_comments = CONFIG["random_comments"]
    message << random_comments[rand(random_comments.length * 2)]
    message.compact.join("\n")[0, 140]
  end
end

