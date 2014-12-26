require 'spec_helper'

RSpec.describe Mountebank::Stub do
  let(:responses) { [] }
  let(:predicates) { [] }
  let(:stub) { Mountebank::Stub.create(responses, predicates) }

  describe '#initialize' do
    it 'creates a new object' do
      expect(stub).to be_a Mountebank::Stub
      expect(stub.responses).to eq []
      expect(stub.predicates).to eq []
      expect(stub.to_json).to eq '{}'
    end
  end

  context 'has responses' do
    let(:responses) { [
        {
          "is" => {statusCode: 200, body:"ohai"}
        }
      ]
    }

    it 'is not empty' do
      expect(stub.responses).to_not be_empty
    end

    it 'is a response' do
      expect(stub.responses.first).to be_a Mountebank::Stub::Response
      expect(stub.responses.first.is[:statusCode]).to eq 200
    end

    it 'renders correct JSON' do
      expect(stub.to_json).to eq '{"responses":[{"is":{"statusCode":200,"body":"ohai"}}]}'
    end
  end
end

