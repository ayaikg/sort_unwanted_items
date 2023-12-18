namespace :line_bot do
  desc "LINEBOT:未断捨離アイテムの通知"
  task push_line_message_expired_items: :environment do
    require 'line_message'

    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    }
    users = User.all
    users.each do |user|
      unless user.authentications.empty?
        expired_items = Item.joins(:notification).where(user_id: user.id).where(disposal_method: :before).where('notifications.notify_date < ?', Date.today)
        unless expired_items.empty?
          names_with_links = expired_items.map do |item|
            LineMessage.item_list(item)
          end
        end
        title = "未断捨離リスト"
        description = "以下のアイテムはすでに通知日を過ぎています。早めの断捨離をおすすめします!"
        message = LineMessage.message_mold(names_with_links, title, description)
        response = client.push_message(user.authentications.first.uid, message)
        p response
      end
    end
  end
end