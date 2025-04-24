# spec/account_number_spec.rb
require 'rspec'
require_relative '../lib/account_number'

RSpec.describe AccountNumber do
  let(:line1) { "    _  _     _  _  _  _  _ " }
  let(:line2) { "  | _| _||_||_ |_   ||_||_|" }
  let(:line3) { "  ||_  _|  | _||_|  ||_| _|" }
  let(:raw_input) { [line1 + "\n", line2 + "\n", line3 + "\n"] }

  describe '#initialize' do
    it 'strips newline characters from each line' do
      account_number = described_class.new(raw_input)
      expect(account_number.raw).to eq([line1, line2, line3])
    end
  end

  describe '#parse_line_length' do
    it 'raises error if lines are not the same length' do
      bad_input = [line1, line2[0..-2], line3]
      expect {
        described_class.new(bad_input).send(:parse_line_length)
      }.to raise_error(ArgumentError, /Not all lines are the same length/)
    end
  end

  describe '#digits' do
    it 'returns a list of Digit objects based on OCR input' do
      stub_const("Digit::HEIGHT", 3)
      stub_const("Digit::WIDTH", 3)

      # Expecting 9 digits (line1.length / Digit::WIDTH == 27 / 3)
      expect(Digit).to receive(:new).exactly(9).times.and_call_original

      account_number = described_class.new(raw_input)
      allow(Digit).to receive(:new).and_return(double("Digit", to_s: "0"))

      digits = account_number.digits
      expect(digits.size).to eq(9)
    end

    it 'raises an error if the number of lines is incorrect' do
      stub_const("Digit::HEIGHT", 3)
      invalid_input = [line1, line2] # Only 2 lines

      expect {
        described_class.new(invalid_input).digits
      }.to raise_error(ArgumentError, /AccountNumber must be initialized with exactly/)
    end
  end

  describe '#to_s' do
    it 'joins parsed digits into a string representation' do
      stub_const("Digit::HEIGHT", 3)
      stub_const("Digit::WIDTH", 3)
      digit_double = double("Digit", to_s: "1")

      allow(Digit).to receive(:new).and_return(digit_double)

      account_number = described_class.new(raw_input)
      expect(account_number.to_s).to eq("1" * 9)
    end
  end
end