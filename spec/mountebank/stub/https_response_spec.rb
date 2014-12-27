require 'spec_helper'

RSpec.describe Mountebank::Stub::HttpsResponse do
  let(:statusCode) { 200 }
  let(:headers) { {"Content-Type" => "application/json"} }
  let(:body) { {foo:"bar"}.to_json }
  let!(:response) { Mountebank::Stub::HttpsResponse.create(statusCode, headers, body) }

  describe '.create' do
    it 'returns response object' do
      expect(response).to be_a Mountebank::Stub::HttpsResponse
      expect(response.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}"}}'
    end
  end
end
