require 'xml_creator'

class GedcomParser
  class Error < StandardError; end

  def call(input_file:)
    assert_file_exists!(input_file)

    input = File.readlines(input_file)

    xml = XMLCreator.new(root: 'gedcom')

    input.each do |line|

    end

    xml.call
  end

  private

  def assert_file_exists!(file_input)
    return true if File.exist?(file_input)

    raise(Error, "File not found: #{file_input}")
  end
end
