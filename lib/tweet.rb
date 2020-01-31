# -*- coding: utf-8 -*-
class Tweet
  def self.tweet_todays_message(twitter, shop_key)
    menu = Shop.find(shop_key).todays
    message = ["今日の日替ランチは #{menu.title} です。"]
    message << 突然の死 if menu.カレー?
    tweet = message.compact.join("\n")[0, 140]
    twitter.update(tweet)
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

  def self.tweet_mentions(twitter, shop_key)
    {7 => "来週はカレー系メニューの日です", 3 => "そろそろカレー系メニューの日ですよ"}.each do |offset, message|
      begin
        menu = Shop.find(shop_key).todays(Date.today+ offset)
        targets = ENV['MENTIONS_TARGET'].to_s.split.uniq
        if menu.カレー? && targets.present?
          targets.each do |target|
            tweet = "#{target} #{message}"[0, 140]
            twitter.update(tweet)
            sleep 0.5
          end
        end
      rescue Shop::NoMenuError
        nil #NOOP
      end
    end
  end
end
