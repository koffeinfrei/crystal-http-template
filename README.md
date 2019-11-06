# crystal-http

## Usage

```
faas-cli template store pull crystal-http
faas-cli new --lang crystal-http function_name
```

### Example

Edit the `function_name/handler.rb` file to return some HTML:

```crystal
require "http/request"
require "http/headers"

class Handler
  def run(request : HTTP::Request)
    {
      body:        "<p>Hello, Crystal. You said: #{request.body.try(&.gets_to_end)}</p>",
      status_code: 200,
      headers:     HTTP::Headers{"Content-Type" => "text/html"},
    }
  end
end
```

Add a shard to the `function_name/shard.yml` if you need additional dependencies.

#### Deploy

```sh
faas-cli up -f function_name.yml
```

## Specification

The handler needs to return a `NamedTuple` with the keys `body`, `headers`,
`status_code`. At least one of the keys must be present. The following is the
type annotation for the return value:

```crystal
NamedTuple(body: String, headers: HTTP::Headers, status_code: Int32) |
NamedTuple(body: String, headers: HTTP::Headers) |
NamedTuple(body: String, status_code: Int32) |
NamedTuple(body: String) |
NamedTuple(headers: HTTP::Headers, status_code: Int32) |
NamedTuple(headers: HTTP::Headers) |
NamedTuple(status_code: Int32)
```

## Credits

This template is inspired by
[ruby-http](https://github.com/openfaas-incubator/ruby-http) and
[crystal_openfaas](https://github.com/TPei/crystal_openfaas)
