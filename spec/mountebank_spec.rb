require 'spec_helper'

RSpec.describe Mountebank do
  describe '.imposters' do
    it 'blank' do
      expect(Mountebank.imposters).to be_empty
    end
  end
end
