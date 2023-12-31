module LineClient
  module_function

  def line_bot_client
    Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    end
  end
end
