class Main
  def initialize(library:)
    @memory   = library.dup
  end

  def playlist(first_song_name: nil)
    @playlist = []

    return @playlist if @memory.empty?

    insert_first_song(first_song_name)
    order_by_last_song_letter

    @playlist
  end

  private

  def insert_first_song(first_song_name = nil)
    if first_song_name
      first_song = @memory.detect { |s| s == first_song_name }
    else
      first_song = @memory[0]
    end
    @playlist << first_song
    @memory.delete(first_song)
  end

  private

  def order_by_last_song_letter
    @found_next_song = true
    while @found_next_song
      song = next_song

      # puts ''
      # puts '-' * 50
      # puts "@playlist = #{@playlist}".center(50)
      # puts "next_song = #{song}"
      # puts '-' * 50
      # puts ''

      if song
        @playlist << song
        @memory.delete(song)
      else
        @found_next_song = false
      end
    end

    @playlist
  end

  def next_song
    @memory.detect{ |s| s[0] == @playlist.last[-1] }
  end
end
