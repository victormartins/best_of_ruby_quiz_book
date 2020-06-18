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
      result = [space, dash * scale, space]
      scale.times { result.push([pipe, space * scale, pipe]) }
      result.push([space, dash * scale, space])
      scale.times { result.push([pipe, space * scale, pipe]) }
      result.push([space, dash * scale, space])
    when '1'
      result = [space, space * scale, space]
      scale.times { result.push([space, space * scale, pipe]) }
      result.push([space, space * scale, space])
      scale.times { result.push([space, space * scale, pipe]) }
      result.push([space, space * scale, space])
    when '2'
      result = [space, dash * scale, space]
      scale.times { result.push([space, space * scale, pipe]) }
      result.push([space, dash * scale, space])
      scale.times { result.push([pipe, space * scale, space]) }
      result.push([space, dash * scale, space])
    else
      raise NotImplementedError, 'Digit Not Found'
    end

    digit_columns = 3
    result.flatten
          .each_slice(digit_columns)
          .reduce([]) { |digit_array, slice| digit_array << slice.join }
  end
end
