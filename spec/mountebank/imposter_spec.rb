require 'spec_helper'

RSpec.describe Mountebank::Imposter do
  before:each do
    reset_mountebank
  end

  let(:port) { 4545 }
  let(:protocol) { Mountebank::Imposter::PROTOCOL_HTTP }

  shared_examples 'blank imposter' do
    it 'valid imposter' do
      expect(imposter).to be_a Mountebank::Imposter
      expect(imposter.port).to eq port
      expect(imposter.protocol).to eq protocol
      expect(imposter.stubs).to be_empty
      expect(imposter.requests).to be_empty
      expect(Mountebank.imposters).to_not be_empty
    end
  end

  describe '.create' do
    context 'new imposter' do
      let(:imposter) { Mountebank::Imposter.create(port, protocol) }

      it_should_behave_like 'blank imposter'
    end

    context 'assumes 2nd argument to be `http`' do
      let(:imposter) { Mountebank::Imposter.create(port) }

      it_should_behave_like 'blank imposter'
    end

    context 'invalid arguments' do
      it 'raises invalid port' do
        expect{ Mountebank::Imposter.create('abcd') }.to raise_error 'Invalid port number'
      end

      it 'raises invalid protocol' do
        expect{ Mountebank::Imposter.create(port, 'seattle') }.to raise_error 'Invalid protocol'
      end
    end
  end

  describe '.get' do
    before do
      Mountebank::Imposter.create(port)
    end

    context 'valid imposter' do
      let(:imposter) { Mountebank::Imposter.find(port) }

      it_should_behave_like 'blank imposter'
    end

    context 'unknown imposter' do
      it 'returns false' do
        expect(Mountebank::Imposter.find(4546)).to_not be
      end
    end
  end
end
