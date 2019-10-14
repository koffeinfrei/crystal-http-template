# crystal-http

## Usage

```
faas template pull https://github.com/koffeinfrei/crystal-http-template
faas new --lang ruby-http homepage
```

### Example

Edit the `homepage/handler.rb` file to return some HTML:

```crystal
require "http/request"
require "http/headers"

class Handler
  def run(request : HTTP::Request) : NamedTuple(body: String, headers: HTTP::Headers | Nil, status_code: Int32 | Nil)
    return {
      body: "<p>Hello, Crystal. You said: #{request.body.try(&.gets_to_end)}</p>",
      status_code: 200,
      headers: HTTP::Headers{"Content-Type" => "text/html"}
    }
  end
end
```

Add a shard to the `homepage/shard.yml` if you need additional dependencies.

#### Deploy

```sh
faas-cli up -f homepage.yml
```

## Credits

This template is inspired by
[ruby-http](https://github.com/openfaas-incubator/ruby-http) and
[crystal_openfaas](https://github.com/TPei/crystal_openfaas)
