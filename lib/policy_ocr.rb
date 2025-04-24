require_relative 'account_number'

module PolicyOcr

  def self.parse(text)
    account_numbers = []
    lines = text.lines
    isolate_account_numbers(lines).map do |account_number|
      acctno = AccountNumber.new(account_number.first(3))
      acctno.digits
      acctno
    end
  end

  def self.isolate_account_numbers(lines)
    lines.each_slice(4).to_a
  end
end