module Lita
  module Handlers
    class DataclipHandler < Handler
      config :top_clicks_all_time_url

      route(/products\shave\sthe\smost\sclicks/, command: true) do |response|
        url = config.top_clicks_all_time_url
        http_response = HTTParty.get(url, follow_redirects: true)
        data = JSON.
          parse(http_response.body).
          fetch("values").
          lazy.
          map { |arr| ({ name: arr[0], clicks: arr[1] }) }.
          take(5)

        msg = "The products with the most clicks are:\n"
        data.each do |source|
          msg << "- *#{source[:name]}* with #{source[:clicks]} clicks\n"
        end

        response.reply(msg)
      end
    end

    Lita.register_handler(DataclipHandler)
  end
end
