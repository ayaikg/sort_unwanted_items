module TextpairApi
  extend ActiveSupport::Concern
  require 'net/https'
  require 'uri'
  require 'json'

  def calculate_similarity(user_items, grouped_items)
    similarity_hash = {}
    user_items.each do |user_item|
      user_item_id = user_item.id
      similarities = []

      grouped_items_names = grouped_items[user_item.category_id] || []
      grouped_items_names.each do |grouped_item_name|
        similarity = post_text(user_item.name, grouped_item_name)
        similarities << similarity if similarity
      end
      # ハッシュオブジェクト[キー] = 値で新しい要素を追加
      similarity_hash[user_item_id] = similarities
    end
    return similarity_hash
  end

  def post_text(text1, text2)
    uri = URI.parse("https://labs.goo.ne.jp/api/textpair")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.request_uri)
    goo_app_id = Rails.application.credentials.dig(:goo, :app_id)
    content = { "app_id" => goo_app_id, "text1" => text1, "text2" => text2 }
    req.content_type = 'application/json'
    req.body = content.to_json
    begin
      res = http.request(req)
      req_result = JSON.parse(res.body)
      return req_result["score"]
    rescue Net::ReadTimeout, Net::OpenTimeout
      nil
    end
  end
end
