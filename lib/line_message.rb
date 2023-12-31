module LineMessage
  module_function

  def item_list(object)
    edit_url = "https://steteco.fly.dev/items/#{object.id}/edit"
    default_url = "https://placehold.jp/15/cccccc/ffffff/80x80.png?text=No%20Image"
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
              url: object.image.present? ? object.image.url : default_url,
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
                  text: object.name,
                  weight: "bold"
                }
              ],
              size: "sm",
              wrap: true
            },
            {
              type: "box",
              layout: "horizontal",
              contents: [
                {
                  type: "button",
                  action: {
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

  def message_mold(names_with_links, title, description)
    {
      type: 'flex',
      altText: title,
      contents: {
        type: 'bubble',
        header: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'text',
              text: title,
              wrap: true,
              size: 'md'
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
                  text: description,
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
            }
          ],
          paddingAll: "0px"
        }
      }
    }
  end
end
