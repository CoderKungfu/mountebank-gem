require 'mountebank'
require 'dotenv'
require 'pry'
Dotenv.load

def reset_mountebank
  Mountebank.reset
end

RSpec.configure do |config|
end

