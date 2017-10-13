class Song
  attr_accessor :artist, :id, :duration, :name

  def initialize(name:, duration: nil, id: nil, artist: nil)
    @name     = name
    @duration = duration
    @id       = id
    @artist   = artist
  end

  def <=>(other_song)
    self.name <=> other_song.name
  end

  def ==(other_song)
    other_song = other_song.name if other_song.respond_to?(:name)
    self.name == other_song
  end
end
