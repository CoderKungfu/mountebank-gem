require 'faraday'

module Mountebank
  class Helper
    # Convert Ruby Hash keys into symbols
    # Source: https://gist.github.com/Integralist/9503099
    def self.symbolize(obj)
      return obj.reduce({}) do |memo, (k, v)|
        memo.tap { |m| m[k.to_sym] = symbolize(v) }
      end if obj.is_a? Hash

      return obj.reduce([]) do |memo, v|
        memo << symbolize(v); memo
      end if obj.is_a? Array

      obj
    end
  end

  class SymbolizeKeys < ::Faraday::Middleware
    def initialize(app = nil, options = {})
      super(app)
      @options = options
      @content_types = Array(options[:content_type])
    end

    def call(environment)
      @app.call(environment).on_complete do |env|
        if env[:body].is_a? Hash
          env[:body] = Helper.symbolize(env[:body])
        end
      end
    end
  end

  if ::Faraday::Middleware.respond_to? :register_middleware
    ::Faraday::Response.register_middleware :symbolize_keys => Mountebank::SymbolizeKeys
  end
end
