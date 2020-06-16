require 'logger'

class LCDNumbers
  LOG_LEVEL = :debug

  def initialize
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

  attr_reader :logger

  def transform(number)
    " __ \n" \
      "|  |\n" \
      "|  |\n" \
      " -- \n" \
      "|  |\n" \
      "|  |\n" \
      " -- \n" \
  end
end
