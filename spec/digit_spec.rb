# spec/digit_spec.rb
require 'rspec'
require_relative '../lib/digit'

RSpec.describe Digit do
  let(:zero_grid) do
    [
      " _ ",
      "| |",
      "|_|"
    ]
  end

  let(:invalid_grid_short) do
    [
      " _ ",
      "| |"
    ]
  end

  let(:invalid_grid_size) do
    [
      " _ ",
      "| |",
      "|__|" # Too many characters in the last row
    ]
  end

  describe '#initialize' do
    it 'initializes with a valid 3x3 grid' do
      expect {
        Digit.new(zero_grid)
      }.not_to raise_error
    end

    it 'raises error for incorrect grid height' do
      expect {
        Digit.new(invalid_grid_short)
      }.to raise_error(ArgumentError, /Grid must be 3x3/)
    end

    it 'raises error for inconsistent row widths' do
      expect {
        Digit.new(invalid_grid_size)
      }.to raise_error(ArgumentError, /Grid must be 3x3/)
    end
  end

  describe '#parse_digit' do
    before do
      stub_const("Digit::HEIGHT", 3)
      stub_const("Digit::WIDTH", 3)
    end

    it 'returns correct digit index if grid matches' do
      digit = Digit.new(zero_grid)
      expect(digit.number).to eq(0)
    end

    it 'returns nil if grid does not match any known digit' do
      unknown_grid = [
        "___",
        "|||",
        "|||"
      ]
      digit = Digit.new(unknown_grid)
      expect(digit.number).to be_nil
    end
  end

  describe '#to_s' do
    it 'returns the string form of the recognized number' do
      allow_any_instance_of(Digit).to receive(:parse_digit).and_return(3)
      digit = Digit.new(zero_grid)
      expect(digit.to_s).to eq("3")
    end
  end
end
