require 'logger'
require 'xml_creator'

class GedcomParser
  class Error < StandardError; end

  require_relative 'parser'

  def call(input_file:)
    assert_file_exists!(input_file)

    input = File.readlines(input_file)

    xml = XMLCreator.new(root: 'gedcom')

    line_parser = GedcomParser::Parser::Line.new

    input.each do |line|
      parse_line = line_parser.call(line)

    end

    xml.call
  end

  def self.logger
    @logger ||= Logger.new(STDOUT, Logger::INFO)
  end

  private

  def assert_file_exists!(file_input)
    return true if File.exist?(file_input)

    raise(Error, "File not found: #{file_input}")
  end
end
