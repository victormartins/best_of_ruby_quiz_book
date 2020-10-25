class GedcomParser
  # This module contains the components that the parser uses
  module Parser
    Dir["#{__dir__}/parser/*.rb"].sort.each { |file| require(file) }
  end
end
