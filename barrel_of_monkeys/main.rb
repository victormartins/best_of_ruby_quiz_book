class Playlist
  include Enumerable

  def initialize
    @playlist = []
  end

  def <<(song)
    @playlist << song
  end

  def each(&block)
    @playlist.each(&block)
  end
end

class Main
  def initialize(library: [])
    @library = library
  end

  def playlist
    @playlist = Playlist.new
    # require 'pry'; binding.pry
    @library.each do |song|
      @playlist << song
    end

    @playlist
  end
end
