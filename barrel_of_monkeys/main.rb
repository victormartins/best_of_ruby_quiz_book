class Playlist
  include Enumerable

  def initialize
    @memory = []
  end

  def order_alphabetically
    @memory = @memory.sort do |song_a, song_b|
      song_a.name <=> song_b.name
    end
  end

  def <<(song)
    @memory << song
  end

  def each(&block)
    @memory.each(&block)
  end
end

class Main
  def initialize(library: [])
    @library = library
  end

  def playlist(first_song_name: nil)
    @playlist = Playlist.new
    # require 'pry'; binding.pry

    @library.each do |song|
      @playlist << song
    end

    @playlist.order_alphabetically

    @playlist
  end
end
