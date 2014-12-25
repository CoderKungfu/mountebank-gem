require "mountebank/version"
require "mountebank/network"

module Mountebank
  extend self

  def self.imposters
    response = Network.get('/imposters')
    return response.body["imposters"] if response.success?

    []
  end
end
