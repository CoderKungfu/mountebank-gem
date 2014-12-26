require 'spec_helper'

RSpec.describe Mountebank::Helper do
  describe '.symbolize' do
    let(:hash) { {
        "foo" => {"bar" => "Baz"},
        "goo" => "balls"
      }
    }
    let(:expected_hash) { {
        :foo => {:bar => "Baz"},
        :goo => "balls"
      }
    }

    it 'symbolizes' do
      expect(Mountebank::Helper.symbolize(hash)).to eq expected_hash
    end
  end
end
