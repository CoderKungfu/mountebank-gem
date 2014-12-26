module Mountebank
  class Imposter
    attr_reader :port, :protocol, :name, :stubs, :requests, :mode

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

    CREATE_PARAMS_HTTP = [:protocol, :port, :name, :stubs]
    CREATE_PARAMS_HTTPS = [:protocol, :port, :name, :stubs]
    CREATE_PARAMS_TCP = [:protocol, :mode, :mode, :name, :stubs]
    CREATE_PARAMS_SMTP = [:protocol, :port, :name]

    def initialize(data={})
      set_attributes(data)
    end

    def self.create(port, protocol=PROTOCOL_HTTP, options={})
      raise 'Invalid port number' unless port.is_a? Integer
      raise 'Invalid protocol' unless PROTOCOLS.include?(protocol)

      data = {port: port, protocol: protocol}.merge(options)
      response = Network.post('/imposters', data)
      return Mountebank::Imposter.new(response.body) if response.success?

      false
    end

    def self.find(port)
      imposter_data = Imposter.get_imposter_config(port)
      return Mountebank::Imposter.new(imposter_data) unless imposter_data.empty?

      false
    end

    def self.delete(port)
      response = Network.delete("/imposters/#{port}")
      response.success? && !response.body.empty?
    end

    def delete!
      delete(@port)
    end

    def reload
      data = Imposter.get_imposter_config(@port)
      set_attributes(data) unless data.empty?

      self
    end

    private

    def self.get_imposter_config(port)
      response = Network.get("/imposters/#{port}")
      response.success? ? response.body : []
    end

    def set_attributes(data)
      @port = data[:port]
      @protocol = data[:protocol]
      @name = data[:name] || "imposter_#{@port}"
      @stubs = []
      if data[:stubs].respond_to?(:each)
        data[:stubs].each do |stub|
          stub = Mountebank::Stub.new(stub) unless stub.is_a? Mountebank::Stub
          @stubs << stub
        end
      end
      @requests = data[:requests] || []
      @mode = data[:mode] || nil
    end
  end
end
