namespace :push_line do
  desc "LINEBOT:notify_dateの通知"
  task push_line_message_notify_date: :environment do
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    }
    users = User.all
    users.each do |user|
      limit_items = Item.joins(:notification).where(user_id: user.id).where(notification: { notify_date: Date.today })
      unless limit_items.any?
        names = limit_items.map { |item| item.name }
        message = {
          type: 'text',
          text: "今日は#{names}の通知日です。アイテムの断捨離は済みましたか？"
        }
        response = client.push_message(user.authentications.uid, message)
        p response
      end
    end
  end
end
