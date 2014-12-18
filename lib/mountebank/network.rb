require 'faraday'
require 'faraday_middleware'

module Mountebank
  class Network
    def self.connection
      @conn ||= Faraday.new(url: mountebank_server_uri) do |conn|
        conn.request :json
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
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end
    end

    def self.put(uri, data)
      connection.put do |req|
        req.url uri
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end
    end

    def self.mountebank_server
      !!ENV['MOUNTEBANK_SERVER'] ? ENV['MOUNTEBANK_SERVER'] : 'localhost'
    end

    def self.mountebank_server_port
      !!ENV['MOUNTEBANK_PORT'] ? ENV['MOUNTEBANK_PORT'] : '2525'
    end

    def self.mountebank_server_uri
      "http://#{mountebank_server}:#{mountebank_server_port}"
    end
  end
end
