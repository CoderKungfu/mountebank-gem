require 'spec_helper'

RSpec.describe Mountebank::Stub::Response do
  let(:data) { {} }
  let(:response) { Mountebank::Stub::Response.new(data) }

  describe '#initialize' do
    it 'creates a new object' do
      expect(response.is).to be_nil
      expect(response.proxy).to be_nil
      expect(response.inject).to be_nil
      expect(response.to_json).to eq '{}'
    end
  end

  context 'add dummy response' do
    let(:data) { {
        :is => {statusCode: 200, body:"ohai"}
      }
    }
    it 'is able to response' do
      expect(response.to_json).to eq '{"is":{"statusCode":200,"body":"ohai"}}'
    end
  end

  context '.with_injection' do
    let(:data) { 'function (request, state, logger){}' }
    let(:response) { Mountebank::Stub::Response.with_injection(data) }

    it 'is valid' do
      expect(response.inject).to eq(data)
    end
  end
end
