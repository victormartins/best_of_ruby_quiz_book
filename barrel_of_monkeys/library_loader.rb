require 'pathname'

class LibraryLoader
  def initialize(xml_path: 'data/SongLibrary.xml')
    @source_path = Pathname.new(xml_path)
    raise 'File Not Found!' unless @source_path.exist?
  end

  def call
    # require 'pry'; binding.pry
    []
  end
end
