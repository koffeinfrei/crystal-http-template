require "http/request"
require "http/headers"

class Handler
  def run(request : HTTP::Request) : NamedTuple(body: String, headers: HTTP::Headers | Nil, status_code: Int32 | Nil)
    return {
      body: "Hello, Crystal. You said: #{request.body.try(&.gets_to_end)}",
      status_code: 200,
      headers: HTTP::Headers{"Content-Type" => "text/plain"}
    }
  end
end
