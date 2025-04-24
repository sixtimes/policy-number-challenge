require_relative '../lib/policy_ocr'

describe PolicyOcr do
  it "loads" do
    expect(PolicyOcr).to be_a Module
  end

  it 'loads the sample.txt' do
    expect(fixture('sample').lines.count).to eq(44)
  end

  describe '.isolate_account_numbers' do
    it 'splits input lines into groups of 4 lines' do
      input_lines = [
        "    _  _     _  _  _  _  _ \n",
        "  | _| _||_||_ |_   ||_||_|\n",
        "  ||_  _|  | _||_|  ||_| _|\n",
        "\n",
        " _  _  _  _  _  _  _  _  _ \n",
        "| || || || || || || || || |\n",
        "|_||_||_||_||_||_||_||_||_|\n",
        "\n"
      ]

      expected = [
        input_lines[0..3],
        input_lines[4..7]
      ]

      result = described_class.isolate_account_numbers(input_lines)
      expect(result).to eq(expected)
    end
  end

  describe '.parse' do
    it 'returns AccountNumber objects for each group of account number lines' do
      account_lines = [
        "    _  _     _  _  _  _  _ \n",
        "  | _| _||_||_ |_   ||_||_|\n",
        "  ||_  _|  | _||_|  ||_| _|\n",
        "\n"
      ]

      text = account_lines.join

      dummy_account_number = instance_double("AccountNumber", digits: "123456789")

      expect(AccountNumber).to receive(:new)
        .with(account_lines.first(3))
        .and_return(dummy_account_number)

      result = described_class.parse(text)

      expect(result).to eq([dummy_account_number])
    end
  end
end
