# Trialday Challenge 

### Introduction

Build a small web framework for writing simple JSON APIs.

Ideally you should base it off [Rack](https://rack.github.io/).

### Requirements

Given the following piece of ruby code:

```ruby
# config.ru

require "trialday"

get "/bla" do
  { results: [1, 2, 3] }
end
```

> The server is run via `bundle exec rackup --port 3000`.

When requested with `curl http://localhost:3000/bla -i`, it should return:

```
HTTP/1.1 200 OK
Content-Type: application/json

{"results": [1, 2, 3]}
```

Given the following piece of ruby code:

```ruby
# config.ru

require "trialday"

get "/bla" do
  { results: [1, 2, 3] }
end

post "/bla" do |params|
  name = params[:name]

  { name: name }
end
```

> `params` contains a deserialized version of any JSON passed in the request body. The Hash keys are accessible as symbols.

When requested with `curl http://localhost:3000/bla -i`, it should return:

```
HTTP/1.1 200 OK
Content-Type: application/json

{"results": [1, 2, 3]}
```

When requested with `curl -XPOST http://localhost:3000/bla -i -H "Content-Type: application/json" -d '{"name": "Mario"}'`, it should return:

```
HTTP/1.1 200 OK
Content-Type: application/json

{"name": "Mario"}
```

### Notes

The server is run via bundle exec rackup --port 3000

Test Case 1: curl http://localhost:3000/bla -i

Test Case 2: curl -XPOST http://localhost:3000/bla -i -H "Content-Type: application/json" -d '{"name": "Mario"}'
