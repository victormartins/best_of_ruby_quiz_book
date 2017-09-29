class Main
  def initialize(library:)
    @memory = library.dup
  end

  def playlist(first_song_name: nil)
    order_playlist(first_song_name) if first_song_name
    @memory
  end

  private

  def order_playlist(first_song_name)
    @memory
  end
end
