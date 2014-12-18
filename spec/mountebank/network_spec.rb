require 'spec_helper'
require 'mountebank/network'

RSpec.describe Mountebank::Network do
  subject{ Mountebank::Network }
  describe '.mountebank_server_uri' do
    it 'returns correct uri' do
      expect(subject.mountebank_server_uri).to eq 'http://127.0.0.1:2525'
    end
  end

  describe '.connection' do
    it 'returns a Faraday instance' do
      expect(subject.connection).to be_a(::Faraday::Connection)
    end
  end

  describe '.get' do
    it 'calls a URL with GET' do
      expect(subject.get('/').status).to eq 200
    end
  end
end
