require 'mountebank'
require 'dotenv'
require 'pry'
require 'open-uri'
Dotenv.load

def reset_mountebank
  Mountebank.reset
end

def test_url(uri)
  open(uri).read
end

RSpec.configure do |config|
end

