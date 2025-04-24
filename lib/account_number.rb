require_relative 'digit'

class AccountNumber
    attr_reader :raw

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
  end