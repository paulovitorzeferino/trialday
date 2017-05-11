require 'spec_helper'
require 'pry'
require 'rack/test'

describe 'Trailday' do

  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  describe '#get' do
    context 'success' do
      before(:each) do
        get "/bla"
      end

      it 'returns content-type' do
        expect(last_response.headers['Content-Type']).to eq("application/json")
      end

      it 'returns json result' do
        expect(last_response.body).to eq({"results"=> [1,2,3]}.to_json)
      end

      it 'returns http code success' do
        expect(last_response.ok?).to be_truthy
      end
    end
  end


end
