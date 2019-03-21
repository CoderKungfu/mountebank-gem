require 'spec_helper'

RSpec.describe 'Examples' do
  before:each do
    reset_mountebank
  end

  describe 'get all imposters' do
    it 'should be empty' do
      expect(Mountebank.imposters).to be_empty
    end
  end

  describe 'create imposter' do
    it 'should create' do
      port = 4545
      protocol = Mountebank::Imposter::PROTOCOL_HTTP
      imposter = Mountebank::Imposter.create(port, protocol, record_requests: true)

      expect(imposter.reload.requests).to be_empty
      test_url('http://127.0.0.1:4545')
      expect(imposter.reload.requests).to_not be_empty
    end
  end

  describe 'create imposter with stub' do
    it 'should have stub' do
      port = 4545
      protocol = Mountebank::Imposter::PROTOCOL_HTTP
      imposter = Mountebank::Imposter.build(port, protocol, record_requests: true)

      # Create a response
      status_code = 200
      headers = {"Content-Type" => "application/json"}
      body = {foo:"bar"}.to_json
      response = Mountebank::Stub::HttpResponse.create(status_code, headers, body)

      imposter.add_stub(response)
      imposter.save!

      expect(imposter.reload.requests).to be_empty
      expect(test_url('http://127.0.0.1:4545')).to eq('{"foo":"bar"}')
      expect(imposter.reload.requests).to_not be_empty
    end
  end

  describe 'create imposter with stub & predicate' do
    it 'should have stub & predicate' do
      port = 4545
      protocol = Mountebank::Imposter::PROTOCOL_HTTP
      imposter = Mountebank::Imposter.build(port, protocol, record_requests: true)

      # Create a response
      status_code = 200
      headers = {"Content-Type" => "application/json"}
      body = {foo:"bar2"}.to_json
      response = Mountebank::Stub::HttpResponse.create(status_code, headers, body)

      # Create a predicate
      data = {equals: {path:"/test"}}
      predicate = Mountebank::Stub::Predicate.new(data)

      imposter.add_stub(response, predicate)
      imposter.save!

      expect(imposter.reload.requests).to be_empty
      expect(test_url('http://127.0.0.1:4545/test')).to eq('{"foo":"bar2"}')
      expect(test_url('http://127.0.0.1:4545')).to eq('')
      expect(imposter.reload.requests).to_not be_empty
    end
  end
end
