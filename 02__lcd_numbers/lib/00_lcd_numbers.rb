require 'logger'

class LCDNumbers
  DEFAULT_SCALE = 2
  LOG_LEVEL = :debug

  def initialize(options = {})
    @scale = options.fetch(:scale) { DEFAULT_SCALE }

    log_formatter = proc do |severity, _datetime, _progname, msg|
      "#{severity} - #{self.class} - #{msg}"
    end
    @logger = Logger.new(STDOUT, level: LOG_LEVEL, formatter: log_formatter)
  end

  def call(digits)
    digits = digits.to_s
    logger.debug { "Input: #{digits}\n" }

    array_of_digits = digits.chars.map do |digit|
      transform(digit)
    end


    if array_of_digits.length > 1
      first_digit = array_of_digits.shift
      result = first_digit
        .zip(*array_of_digits)
        .map { |s| s.join(' ') }
    else
      result = array_of_digits
    end

    result = result
      .join("\n")
      .concat("\n")


    logger.debug { "Output:\n#{result}\n" }
    result
  end

  private

  attr_reader :logger, :scale

  def transform(digit)
    dash = '-'
    pipe = '|'
    space = ' '

    case digit
    when '0'
      top            = [space, dash * scale, space]
      first_vertical = [pipe, space * scale, pipe]
      middle         = [space, dash * scale, space]
      second_middle  = [pipe, space * scale, pipe]
      bottom         = [space, dash * scale, space]
    when '1'
      top            = [space, space * scale, space]
      first_vertical = [space, space * scale, pipe]
      middle         = [space, space * scale, space]
      second_middle  = [space, space * scale, pipe]
      bottom         = [space, space * scale, space]
    when '2'
      top            = [space, dash * scale, space]
      first_vertical = [space, space * scale, pipe]
      middle         = [space, dash * scale, space]
      second_middle  = [pipe, space * scale, space]
      bottom         = [space, dash * scale, space]
    else
      raise NotImplementedError, 'Digit Not Found'
    end


    result = build_letter(
      top: top,
      first_vertical: first_vertical,
      middle: middle,
      second_middle: second_middle,
      bottom: bottom
    )

    digit_columns = 3 #result.first.length

    result.flatten
          .each_slice(digit_columns)
          .reduce([]) { |digit_array, slice| digit_array << slice.join }
  end

  def build_letter(top:, first_vertical:, middle:, second_middle:, bottom:)
    [].tap do |lcd|
      lcd.push(top)
      scale.times { lcd.push(first_vertical) }
      lcd.push(middle)
      scale.times { lcd.push(second_middle) }
      lcd.push(bottom)
    end
  end
end
