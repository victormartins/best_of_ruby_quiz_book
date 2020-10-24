require 'xml_creator'

class GedcomParser
  def call(input:)
    xml = XMLCreator.new(root: 'gedcom')
    xml.call
  end
end
