require 'logger'

class MadLib
  QUESTION_START = 'Please enter'.freeze
  PLACEHOLDER_MATCHER = /(?:\(\(([^)]+))\)\)/

  def initialize(template:)
    @template = template
    @logger = Logger.new(STDOUT, level: :debug)

    logger.debug { "#{self.class} - Loaded template #{@template}" }
  end

  def questions
    place_holders = @template.scan(PLACEHOLDER_MATCHER)

    result = place_holders.map do |question|
      "#{QUESTION_START} #{question.first}:"
    end

    logger.debug { "#{self.class} - Questions: #{result}" }
    result
  end

  def answers(answers)
    placeholders = @template.split(PLACEHOLDER_MATCHER)
    answers = answers.dup

    placeholders.map.with_index do |original_text, index|
      if index.even?
        original_text
      else
        answers.shift
      end
    end.join
  end

  attr_reader :logger
end
