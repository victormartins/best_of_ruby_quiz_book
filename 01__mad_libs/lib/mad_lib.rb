require 'logger'

class MadLib
  QUESTION_START = 'Please enter'.freeze
  PLACEHOLDER_MATCHER = /\(\((.*)\)\)/

  def initialize(template:)
    @template = template
    @logger = Logger.new(STDOUT, level: :debug)

    logger.debug { "#{self.class} - Loaded template #{@template}" }
  end

  def questions
    place_holders = @template.match(PLACEHOLDER_MATCHER).captures

    result = place_holders.map do |question|
      "#{QUESTION_START} #{question}:"
    end

    logger.debug { "#{self.class} - Questions: #{result}" }
    result
  end

  def answers(answers)
    @template.gsub(PLACEHOLDER_MATCHER, answers.first)
  end

  attr_reader :logger
end
