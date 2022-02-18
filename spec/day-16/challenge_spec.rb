# frozen_string_literal: true

require 'day-16/challenge'

describe Challenge do
  context "D2FE28" do 
    let(:challenge) { Challenge.new("D2FE28") }
    context 'initialize' do
      it "calculates the binary correctly" do
        expect(challenge.binary.join).to eq('110100101111111000101000')
      end
    end
    context 'result' do
      it "calculates correct sum of versions" do
        expect(challenge.result).to eq(6)
      end
    end
  end

  context "38006F45291200" do
    let(:challenge) { Challenge.new("38006F45291200") }

    it "calculates correct result" do
      expect(challenge.result).to eq(9)
    end
  end

  context "EE00D40C823060" do
    let(:challenge) { Challenge.new("EE00D40C823060") }

    it "calculates correct result" do
      expect(challenge.result).to eq(14)
    end
  end
end