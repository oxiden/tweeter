# -*- coding: utf-8 -*-
class Tweet
  def self.tweet_todays_message(shop_key = 1)
    menu = Shop.find(shop_key).todays
    message = ["今日の日替定食は #{menu.title} です。"]
    message << 突然の死 if menu.カレー?
    tweet = message.compact.join("\n")[0, 140]
    Twitter.update(tweet)
  rescue Shop::NoMenuError
    nil # NOOP
  end

  def self.突然の死
    <<-EOS

＿人人人人人人人＿
＞　カレー！！　＜
￣Y^Y^Y^Y^Y^Y￣
  EOS
  end
end
