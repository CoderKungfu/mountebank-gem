require 'spec_helper'

RSpec.describe Mountebank::Stub::Predicate do
  let(:data) { {} }
  let(:predicate) { Mountebank::Stub::Predicate.new(data) }

  describe '#initialize' do
    it 'creates a new object' do
      expect(predicate.equals).to be_nil
      expect(predicate.caseSensitive).to be_nil
      expect(predicate.except).to be_nil
      expect(predicate.to_json).to eq '{}'
    end

    context 'sets value' do
      let(:data) { {equals: {path:'/test'}} }

      it 'has path' do
        expect(predicate.equals).to eq({path:'/test'})
        expect(predicate.to_json).to eq '{"equals":{"path":"/test"}}'
      end
    end
  end
end
