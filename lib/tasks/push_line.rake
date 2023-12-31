namespace :push_line do
  desc "LINEBOT:notify_dateの通知"
  task push_line_message_notify_date: :environment do
    require 'line_message'
    require 'line_client'

    users = User.all
    users.each do |user|
      unless user.authentications.empty?
        limit_items = Item.joins(:notification).where(user_id: user.id).where(disposal_method: :before).where(notification: { notify_date: Date.today })
        unless limit_items.empty?
          names_with_links = limit_items.map do |item|
            LineMessage.item_list(item)
          end
        
          title = "今日の断捨離アイテム"
          description = "今日は通知日設定をしたアイテムがあります。断捨離できたアイテムは、編集ページで処分方法を選択しましょう!"
          message = LineMessage.message_mold(names_with_links, title, description)
          response = LineClient.line_bot_client.push_message(user.authentications.first.uid, message)
          p response
        end
      end
    end
  end
end