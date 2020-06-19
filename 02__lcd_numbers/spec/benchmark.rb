require 'logger'

class DataGenerator
  LOG_LEVEL = :debug
  NUMBER_OF_ENTRIES = 1_000_000
  NUMBER_OF_DIGITS = 10
  BENCHMARKING_FILE_NAME = 'benchmark_data.txt'

  def initialize
    log_formatter = proc do |severity, _datetime, _progname, msg|
      "#{severity} - #{self.class} - #{msg}\n"
    end
    @logger = Logger.new(STDOUT, level: LOG_LEVEL, formatter: log_formatter)
  end

  def call
    if File.exist?(BENCHMARKING_FILE_NAME)
      puts "Loading Benchmarking file: #{BENCHMARKING_FILE_NAME}"
    else
      generate_benchmark_data
      logger.info { "Generated #{NUMBER_OF_ENTRIES} numbers with #{NUMBER_OF_DIGITS} digits."}
    end
  end

  private

  attr_reader :logger

  def generate_benchmark_data
    file = File.new(BENCHMARKING_FILE_NAME, 'a')

    NUMBER_OF_ENTRIES.times do |entry_index|
      digits = []

      NUMBER_OF_DIGITS.times do
        digits << (rand * 10).floor.to_s
      end

      digits = digits.join

      logger.debug { "Generated: #{digits} (#{NUMBER_OF_ENTRIES - entry_index} to go.)" }
      file.puts(digits)
    end

  rescue StandardError => ex
    logger.error { "An error was raised. Will try to save the file. file_name: #{BENCHMARKING_FILE_NAME}" }
    raise ex
  ensure
    file.close
  end
end

DataGenerator.new.call
