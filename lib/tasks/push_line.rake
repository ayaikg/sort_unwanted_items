namespace :push_line do
  desc "LINEBOT:notify_dateの通知"
  task push_line_message_notify_date: :environment do
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    }
    users = User.all
    users.each do |user|
      unless user.authentications.empty?
        message = item_list(user)
        response = client.push_message(user.authentications.first.uid, message)
        p response
      end
    end
  end

  def item_list(user)
    limit_items = Item.joins(:notification).where(user_id: user.id).where(disposal_method: :before).where(notification: { notify_date: Date.today })
    unless limit_items.empty?
      names_with_links = limit_items.map do |item|
        edit_url = "https://steteco.fly.dev/items/#{item.id}/edit"
        default_url = "https://placehold.jp/80x80.png"
          {
            type: "box",
            layout: "horizontal",
            contents: [
              {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "image",
                    url: item.image.present? ? item.image.url : default_url,
                    aspectMode: "cover",
                    size: "full"
                  }
                ],
                cornerRadius: "100px",
                width: "72px",
                height: "72px"
              },
              {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    contents: [
                      {
                        type: "span",
                        text: item.name,
                        weight: "bold"
                      }
                    ],
                    size: "sm",
                    wrap: true,
                  },
                  {
                    type: "box",
                    layout: "horizontal",
                    contents: [
                      {
                        type: "button",
                        action:{
                          type: "uri",
                          label: "編集ページにいく",
                          uri: edit_url
                        },
                        style: "link",
                        height: "sm"
                      }
                    ]
                  }
                ]
              }
            ],
            spacing: "xl",
            paddingAll: "20px"
          }
      end
    end
    {
      type: 'flex',
      altText: '今日の断捨離アイテム',
      contents: {
        type: 'bubble',
        header:{
          type: 'box',
          layout: 'horizontal',
          contents:[
            {
              type: 'text',
              text: '今日の断捨離アイテム',
              wrap: true,
              size: 'md',
            }
          ]
        },
        body: {
          type: 'box',
          layout: 'vertical',
          contents: [
            {
              type: "box",
              layout: "horizontal",
              contents: [
                {
                  type: 'text',
                  text: "今日は通知日設定をしたアイテムがあります。断捨離できたアイテムは、編集ページで処分方法を選択しましょう!",
                  wrap: true,
                  size: 'sm',
                  margin: "lg"
                }
              ]
            },
            {
              type: "box",
              layout: "vertical",
              contents: names_with_links
            },
          ],
          paddingAll: "0px"
        }
      }
    }
  end
end