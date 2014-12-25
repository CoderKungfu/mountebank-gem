module Mountebank
  class Imposter
    attr_reader :port, :protocol, :stubs, :requests

    def initialize(data={})
      @port = data["port"]
      @protocol = data["protocol"]
      @stubs = data["stubs"] || []
      @requests = data["requests"] || []
    end

    def self.create(port, protocol='http')
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
