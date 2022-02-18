# frozen_string_literal: true

require 'day-16/challenge'

describe Challenge do
  context 'initialize' do
    let(:challenge) { Challenge.new("D2FE28") }

    it "calculates the binary correctly" do
      expect(challenge.binary.join).to eq('110100101111111000101000')
    end
  end
end