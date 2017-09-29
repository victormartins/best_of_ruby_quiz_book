class Main
  def initialize(library:)
    @memory = library.dup
  end

  def playlist(first_song_name: nil)
    set_first_song(first_song_name) if first_song_name
    @memory
  end

  private

  def set_first_song(first_song_name)
    song = @memory.delete(first_song_name)
    @memory = [song] + @memory
  end
end
