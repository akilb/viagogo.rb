require 'viagogo'
require 'webmock/rspec'

def a_delete(path)
  a_request(:delete, Viagogo::Client::API_ENDPOINT + path)
end

def a_get(path)
  a_request(:get, Viagogo::Client::API_ENDPOINT + path)
end

def a_head(path)
  a_request(:head, Viagogo::Client::API_ENDPOINT + path)
end

def a_post(path)
  a_request(:post, Viagogo::Client::API_ENDPOINT + path)
end

def a_put(path)
  a_request(:put, Viagogo::Client::API_ENDPOINT + path)
end

def stub_delete(path)
  stub_request(:delete, Viagogo::Client::API_ENDPOINT + path)
end

def stub_get(path)
  stub_request(:get, Viagogo::Client::API_ENDPOINT + path)
end

def stub_head(path)
  stub_request(:head, Viagogo::Client::API_ENDPOINT + path)
end

def stub_post(path)
  stub_request(:post, Viagogo::Client::API_ENDPOINT + path)
end

def stub_put(path)
  stub_request(:put, Viagogo::Client::API_ENDPOINT + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
