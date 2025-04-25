require_relative 'digit'

class AccountNumber
    attr_reader :raw
    attr_reader :digits

    LENGTH = 9

    def initialize(raw)
        @raw = raw.map { |line| line.delete("\n") }
    end

    def digits
        @digits ||= parse_digits
    end

    def parse_digits
        digit_list = []
        raise ArgumentError, "AccountNumber must be initialized with exactly #{Digit::HEIGHT} lines" unless @raw.size == Digit::HEIGHT
        rows = raw.map { |line| line.scan(/.{#{Digit::WIDTH}}/) }
        for col in 0...(length / Digit::WIDTH)
            digit_grid = []
            for row in 0...Digit::HEIGHT
                digit_grid << rows[row][col]
            end
            digit_list << Digit.new(digit_grid)
        end
        raise ArgumentError, "Account numbers should be #{LENGTH} digits long" unless digit_list.length == LENGTH
        digit_list
    end

    def to_s
        digits.join("")
    end

    def length
        @length ||= parse_line_length
    end

    def parse_line_length
        return nil if @raw.empty?

        line_length = @raw.first.length
        
        raise ArgumentError, "Not all lines are the same length" unless @raw.all? { |line| line.length == line_length }
        line_length
    end

    def valid_checksum?
        return false unless legible?
        sum = digits.reverse.each_with_index.sum do |digit, index|
            digit.number * (index + 1)
        end
        
        sum % 11 == 0
    end

    def legible?
        digits.all? { |digit| digit.valid? }
    end
end