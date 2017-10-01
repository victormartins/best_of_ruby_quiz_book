class Playlist
  include Enumerable

  def initialize
    @playlist = []
  end

  def << (song)
    @playlist << song
  end

  def last
    @playlist.last
  end

  def first
    @playlist.first
  end

  def each(&block)
    @playlist.each(&block)
  end
end
