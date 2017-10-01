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

  def duration
    @playlist.inject(BigDecimal.new('0')) do |sum, song|
      sum += BigDecimal.new(song.duration)
    end
  end
end
