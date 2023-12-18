require 'line/bot'

class LinebotController < ApplicationController
  include LineMessage

  protect_from_forgery :except => [:callback]

  def client
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each { |event|
      user_id = event['source']['userId']
      user = User.joins(:authentications).find_by(authentications: { uid: user_id })
      if event.message['text'].include?("未断捨離リスト")
        expired_items = Item.joins(:notification).where(user_id: user.id).where(disposal_method: :before).where('notifications.notify_date < ?', Date.today)
        if !expired_items.empty?
          names_with_links = expired_items.map do |item|
            item_list(item)
          end
          title = "未断捨離リスト"
          description = "以下のアイテムはすでに通知日を過ぎています。早めの断捨離をおすすめします!"
          message = message_mold(names_with_links, title, description)
        else
          message = {
            type: "text",
            text: "現在、通知日を過ぎているアイテムはありません。素晴らしいです!この調子で断捨離を暖がりましょう!"
          }
        end
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          client.reply_message(event['replyToken'], message)
        end
      end
      }
      head :ok
  end
end
