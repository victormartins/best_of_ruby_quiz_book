require 'logger'

class LCDNumbers
  DEFAULT_SCALE = 2
  DASH          = '-'.freeze
  PIPE          = '|'.freeze
  SPACE         = ' '.freeze
  LOG_LEVEL     = :debug

  def initialize(options = {})
    @scale = options.fetch(:scale) { DEFAULT_SCALE }
    @dash = options.fetch(:dash) { DASH }
    @pipe = options.fetch(:pipe) { PIPE }
    @space = options.fetch(:space) { SPACE }

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

  attr_reader :logger, :scale, :dash, :space, :pipe

  def transform(digit)
    case digit
    when '0'
      top            = [space, dash, space]
      first_vertical = [pipe, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [pipe, space, pipe]
      bottom         = [space, dash, space]
    when '1'
      top            = [space, space, space]
      first_vertical = [space, space, pipe]
      middle         = [space, space, space]
      second_middle  = [space, space, pipe]
      bottom         = [space, space, space]
    when '2'
      top            = [space, dash, space]
      first_vertical = [space, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [pipe, space, space]
      bottom         = [space, dash, space]
    when '3'
      top            = [space, dash, space]
      first_vertical = [space, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [space, space, pipe]
      bottom         = [space, dash, space]
    when '4'
      top            = [space, space, space]
      first_vertical = [pipe, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [space, space, pipe]
      bottom         = [space, space, space]
    when '5'
      top            = [space, dash, space]
      first_vertical = [pipe, space, space]
      middle         = [space, dash, space]
      second_middle  = [space, space, pipe]
      bottom         = [space, dash, space]
    when '6'
      top            = [space, dash, space]
      first_vertical = [pipe, space, space]
      middle         = [space, dash, space]
      second_middle  = [pipe, space, pipe]
      bottom         = [space, dash, space]
    when '7'
      top            = [space, dash, space]
      first_vertical = [space, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [space, space, pipe]
      bottom         = [space, space, space]
    when '8'
      top            = [space, dash, space]
      first_vertical = [pipe, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [pipe, space, pipe]
      bottom         = [space, dash, space]
    when '9'
      top            = [space, dash, space]
      first_vertical = [pipe, space, pipe]
      middle         = [space, dash, space]
      second_middle  = [space, space, pipe]
      bottom         = [space, dash, space]
    else
      raise NotImplementedError, "Digit Not Found: #{digit}"
    end


    result = build_letter(
      top:            top,
      first_vertical: first_vertical,
      middle:         middle,
      second_middle:  second_middle,
      bottom:         bottom
    )

    number_of_lcd_columns = result.first.length
    result.flatten
          .each_slice(number_of_lcd_columns)
          .reduce([]) { |digit_array, slice| digit_array << slice.join }
  end

  def build_letter(top:, first_vertical:, middle:, second_middle:, bottom:)
    [].tap do |lcd|
      lcd.push(top)
      scale.times { lcd.push(first_vertical.dup) } # scale vertically. duplicate to ensure unique instances
      lcd.push(middle)
      scale.times { lcd.push(second_middle.dup) } # scale vertically. duplicate to ensure unique instances
      lcd.push(bottom)
    end.map.with_index do |lcd_row, index|
      char = lcd_row[1]
      lcd_row[1] = char * scale # scale horizontally
      lcd_row
    end
  end
end
