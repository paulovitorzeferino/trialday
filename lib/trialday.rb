require "rack"
require "json"

METHODS = ['get']
HTTP_SUCCESS = 200

def routes_mapping
  @routes_mapping ||= {}
end

def url_map_parameter_builder
  Proc.new do |env|
    response_builder(routes_mapping['get'])
  end
end

def http_header
  {}.tap do |header|
    header['Content-Type'] = 'application/json'
  end
end

def response_builder(block)
  [ HTTP_SUCCESS, http_header , [block.call.to_json] ]
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
