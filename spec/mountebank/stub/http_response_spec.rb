require 'spec_helper'

RSpec.describe Mountebank::Stub::HttpResponse do
  let(:statusCode) { 200 }
  let(:headers) { {"Content-Type" => "application/json"} }
  let(:body) { {foo:"bar"}.to_json }
  let!(:response) { Mountebank::Stub::HttpResponse.create(statusCode, headers, body) }
  let!(:response_with_behaviors) { Mountebank::Stub::HttpResponse.create(statusCode, headers, body, {wait: 10000}) }

  describe '.create' do
    it 'returns response object' do
      expect(response).to be_a Mountebank::Stub::HttpResponse
      expect(response.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}"}}'
    end

    it 'returns a response object' do
      expect(response_with_behaviors).to be_a Mountebank::Stub::HttpResponse
      expect(response_with_behaviors.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}"},"_behaviors":{"wait":10000}}'
    end
  end
end
