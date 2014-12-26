require 'faraday'
require 'faraday_middleware'

module Mountebank
  class Network
    def self.connection
      @conn ||= Faraday.new(url: mountebank_server_uri) do |conn|
        conn.request :json
        conn.response :symbolize_keys, :content_type => /\bjson$/
        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def self.get(uri)
      connection.get(uri)
    end

    def self.post(uri, data)
      connection.post do |req|
        req.url uri
        req.body = data
      end
    end

    def self.put(uri, data)
      connection.put do |req|
        req.url uri
        req.body = data
      end
    end

    def self.delete(uri)
      connection.delete do |req|
        req.url uri
      end
    end

    def self.mountebank_server
      ENV['MOUNTEBANK_SERVER'] || 'localhost'
    end

    def self.mountebank_server_port
      ENV['MOUNTEBANK_PORT'] || '2525'
    end

    def self.mountebank_server_uri
      "http://#{mountebank_server}:#{mountebank_server_port}"
    end
  end
end
