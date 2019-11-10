require_relative "./dataclip_handler"

Lita.configure do |config|
config.robot.name = "Dot"

  config.robot.locale = :en

  config.robot.log_level = :info
  config.robot.admins = [ENV.fetch("DOT_ADMIN_ID")]

  config.robot.adapter = :slack
  config.adapters.slack.token = ENV.fetch("DOT_SLACK_TOKEN")

  config.http.port = ENV["PORT"] || 3000
  config.redis = { url: ENV.fetch("REDIS_URL") }

  dataclip = config.handlers.dataclip_handler
  dataclip.top_clicks_all_time_url = ENV.fetch("DOT_API_URL")
end
