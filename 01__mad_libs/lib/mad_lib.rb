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
    place_holders = @template.scan(PLACEHOLDER_MATCHER).map(&:first)

    result = place_holders.map do |place_holder|
      if place_holder.include?(':')
        logger.debug { "#{self.class} - Key/Value Placeholder: #{place_holder}" }

        key_value = place_holder.split(':')
        key = key_value.first.strip

        question = key_value.last.strip
      elsif place_holder.split.length == 1
        logger.debug { "#{self.class} - Ignoring Key: #{place_holder}" }
        question = nil
      else
        question = place_holder
      end

      full_question(question) if question
    end.compact

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

  private

  def full_question(question)
    "#{QUESTION_START} #{question}:"
  end
end
