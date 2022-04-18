module Mountebank
  class Imposter
    attr_reader :port, :protocol, :name, :stubs, :requests, :matches, :mode, :record_requests

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

    def self.build(port, protocol=PROTOCOL_HTTP, options={})
      raise 'Invalid port number' unless port.is_a? Integer
      raise 'Invalid protocol' unless PROTOCOLS.include?(protocol)
      
      data = {port: port, protocol: protocol}.merge(options)
      Mountebank::Imposter.new(data)
    end

    def save!
      delete!
      response = Network.post('/imposters', replayable_data)
      return reload if response.success?

      false
    end

    def self.create(port, protocol=PROTOCOL_HTTP, options={})
      self.build(port, protocol, options).save!
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
      Imposter.delete(@port)
    end

    def reload
      data = Imposter.get_imposter_config(@port)
      set_attributes(data) unless data.empty?

      self
    end

    def add_stub(response=nil, predicate=nil)
      responses, predicates = [], []

      if response.is_a? Array
        responses = response
      elsif response.is_a? Mountebank::Stub::Response
        responses << response
      end

      if predicate.is_a? Array
        predicates = predicate
      elsif predicate.is_a? Mountebank::Stub::Predicate
        predicates << predicate
      end

      @stubs << Mountebank::Stub.create(responses, predicates)
    end

    def replayable_data
      data = serializable_hash
      data.delete(:requests)
      data.delete(:matches)

      data
    end

    def to_json(*args)
      serializable_hash.to_json(*args)
    end

    private

    def serializable_hash
      data = {port: @port, protocol: @protocol, name: @name}
      data[:stubs] = @stubs unless @stubs.empty?
      data[:requests] = @requests unless @requests.empty?
      data[:matches] = @matches unless @matches.empty?
      data[:mode] = @mode unless @mode.nil?
      data[:recordRequests] = @record_requests unless @record_requests.nil?
      data
    end

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
      @matches = data[:matches] || []
      @mode = data[:mode] || nil
      @record_requests = data[:record_requests] || data[:recordRequests] || false
    end
  end
end
