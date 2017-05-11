require "rack"
require "json"
require "insensitive_hash"

METHODS = ['get','post']
HTTP_SUCCESS = 200

def routes_mapping
  @routes_mapping ||= {}
end

def url_map_parameter_builder
  Proc.new do |env|
    request = Rack::Request.new(env)
    request_method = request.request_method.downcase
    params = JSON.parse(request.body.read).insensitive if request_method == 'post'
    response_builder(params, routes_mapping[request_method])
  end
end

def http_header
  {}.tap do |header|
    header['Content-Type'] = 'application/json'
  end
end

def response_builder(params, block)
  [ HTTP_SUCCESS, http_header , [block.call(params).to_json] ]
end

def build_app
  Rack::URLMap.new routes_mapping['route'] => url_map_parameter_builder
end

METHODS.each do |method|
  define_method method do |action, &block|
    routes_mapping['route'] ||= action
    routes_mapping[method] = block
  end
end
