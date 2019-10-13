require "http/server"
require "./function/handler"

server = HTTP::Server.new do |context|
  handler = Handler.new
  response_triple = handler.run(context.request)

  if response_triple[:status_code]?
    context.response.status_code = response_triple[:status_code]
  end

  if response_triple[:headers]?
    response_triple[:headers].each do |key, value|
      context.response.headers[key] = value
    end
  end

  context.response.print(response_triple[:body])
end

address = server.bind_tcp "0.0.0.0", 5000
server.listen
