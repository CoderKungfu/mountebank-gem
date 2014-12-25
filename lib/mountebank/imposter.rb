module Mountebank
  class Imposter
    attr_reader :port, :protocol, :stubs, :requests

    PROTOCOL_HTTP = 'http'
    PROTOCOL_HTTPS = 'https'
    PROTOCOL_SMTP = 'smtp'
    PROTOCOL_TCP = 'tcp'

    PROTOCOLS = [
      PROTOCOL_HTTP,
      PROTOCOL_HTTPS,
      PROTOCOL_SMTP,
      PROTOCOL_TCP
    ]

    def initialize(data={})
      @port = data["port"]
      @protocol = data["protocol"]
      @stubs = data["stubs"] || []
      @requests = data["requests"] || []
    end

    def self.create(port, protocol=PROTOCOL_HTTP)
      raise 'Invalid port number' unless port.is_a? Integer
      raise 'Invalid protocol' unless PROTOCOLS.include?(protocol)

      data = {port: port, protocol: protocol}
      response = Network.post('/imposters', data)
      return Mountebank::Imposter.new(response.body) if response.success?

      return false
    end

    def self.find(port)
      response = Network.get("/imposters/#{port}")
      return Mountebank::Imposter.new(response.body) if response.success?

      return false
    end
  end
end
