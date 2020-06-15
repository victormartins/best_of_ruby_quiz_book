# frozen_string_literal: true

require 'logger'

class MadLib
  LOG_LEVEL = :info
  QUESTION_START = 'Please enter'
  PLACEHOLDER_MATCHER = /(?:\(\(([^)]+))\)\)/.freeze

  def initialize(template:)
    @template = template

    log_formatter = proc do |severity, _datetime, _progname, msg|
      "#{severity} - #{msg}\n"
    end
    @logger = Logger.new(STDOUT, level: LOG_LEVEL, formatter: log_formatter)

    logger.debug { "#{self.class} - Loaded template: \"#{@template}\"" }
  end

  def questions
    result = place_holders.map do |place_holder|
      question = question_from(place_holder)
      full_question(question) if question
    end.compact

    logger.debug { "#{self.class} - Questions: #{result}" }
    result
  end

  def answers(answers)
    logger.debug { "#{self.class} - Received answers: #{answers}" }

    answers = answers.dup
    result = @template
    key_values = {}

    place_holders.each do |place_holder|
      logger.debug { "#{self.class} - Matching answer for place_holder: #{place_holder}" }

      if key_value_place_holder?(place_holder)
        answer = answers.shift
        key = key_question_from(place_holder)[0]
        key_values[key] = answer
      elsif key_place_holder?(place_holder)
        answer = key_values.fetch(place_holder)
      else
        answer = answers.shift
      end

      result = result.gsub(/\(\(#{place_holder}\)\)/, answer)
    end
    result
  end

  attr_reader :logger

  private

  def full_question(question)
    "#{QUESTION_START} #{question}:"
  end

  def place_holders
    @place_holders ||= @template.scan(PLACEHOLDER_MATCHER).map(&:first)
  end

  def question_from(place_holder)
    if key_value_place_holder?(place_holder)
      logger.debug { "#{self.class} - Key/Value Placeholder: #{place_holder}" }

      question = key_question_from(place_holder)[1]
    elsif key_place_holder?(place_holder)
      logger.debug { "#{self.class} - Ignoring Key: #{place_holder}" }

      question = nil
    else
      question = place_holder
    end

    question
  end

  def key_value_place_holder?(place_holder)
    place_holder.include?(':')
  end

  def key_place_holder?(place_holder)
    place_holder.split.length == 1
  end

  def key_question_from(place_holder)
    key_value = place_holder.split(':')
    key = key_value.first.strip
    question = key_value.last.strip
    [key, question]
  end
end
