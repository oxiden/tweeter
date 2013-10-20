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

  def self.tweet_notice_for_curry(shop_key = 1, date = Date.today)
    {7 => "来週はカレー系メニューの日です", 3 => "そろそろカレー系メニューの日ですよ"}.each do |offset, message|
      begin
        menu = Shop.find(shop_key).todays(date + offset)
        targets = ENV['MENTIONS_TARGET'].to_s.split.uniq
        if menu.カレー? && targets.present?
          targets.each do |target|
            tweet = "#{target} #{message}"[0, 140]
            Twitter.update(tweet)
          end
        end
      rescue Shop::NoMenuError
        nil #NOOP
      end
    end
  end
end
