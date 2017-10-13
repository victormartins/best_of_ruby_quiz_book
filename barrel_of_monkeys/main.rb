class Playlist
  include Enumerable

  def initialize
    @memory = []
  end

  def order_by_last_letter
    @memory = @memory.sort do |song_a, song_b|
      song_a.name[-1] <=> song_b.name[0]
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

    @playlist.order_by_last_letter

    @playlist
  end
end
