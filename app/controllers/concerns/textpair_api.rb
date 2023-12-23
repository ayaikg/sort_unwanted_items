module TextpairApi
  
  def post_message(text1, text2)
    uri = URI.parse("https://labs.goo.ne.jp/api/textpair")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.request_uri)
    goo_app_id = Rails.application.credentials.dig(:goo, :app_id)
    content = { "app_id" => goo_app_id, "text1" => text1, "text2" => text2 }
    req.content_type = 'application/json'
    req.body = content.to_json
    begin
      res = http.request(req)
      req_result = JSON.parse(res.body)
      return req_result["score"] if req_result["score"]
      # 0.50798434
    rescue Net::ReadTimeout, Net::OpenTimeout
      return nil
    end
  end
end