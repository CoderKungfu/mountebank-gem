require 'spec_helper'

RSpec.describe Mountebank do
  before:each do
    reset_mountebank
  end

  describe '.reset' do
    it 'returns' do
      expect(Mountebank.reset).to be
    end
  end

  describe '.imposters' do
    context 'no imposters' do
      it 'blank' do
        expect(Mountebank.imposters).to be_empty
      end
    end

    context 'has imposters' do
      before do
        Mountebank::Imposter.create(4545)
      end

      it 'not empty' do
        expect(Mountebank.imposters).to_not be_empty
      end

      it 'returns valid imposter' do
        expect(Mountebank.imposters.first).to be_a Mountebank::Imposter
      end
    end
  end
end
