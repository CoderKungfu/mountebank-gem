require 'mountebank'
require 'dotenv'
require 'pry'
require 'open-uri'
Dotenv.load

def reset_mountebank
  Mountebank.reset
end

def test_url(uri)
  URI.open(uri).read
end

RSpec.configure do |config|
end

