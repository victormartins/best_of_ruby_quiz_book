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

  def call(number)
   logger.debug { "Input: #{number}\n" }
   result = transform(number)
   puts result
   result
  end

  private

  attr_reader :logger, :scale

  def transform(number)
    dash = '-'
    pipe = '|'
    space = ' '

    a = [space, dash * scale, space]
    scale.times { a.push([pipe, space * scale, pipe]) }
    a.push([space, dash * scale, space])
    scale.times { a.push([pipe, space * scale, pipe]) }
    a.push([space, dash * scale, space])

    a.flatten
     .each_slice(3)
     .reduce([]) { |result, slice| result << slice.join }
     .join("\n")
     .concat("\n")
  end
end
