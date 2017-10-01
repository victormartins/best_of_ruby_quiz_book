require_relative 'library_loader'

class Main
  def initialize(library: LibraryLoader.new.call)
    @memory   = library.dup
  end

  def playlist(first_song_name: nil, last_song_name: nil)
    @playlist = []
    return @playlist if @memory.empty?

    insert_first_song(first_song_name)
    order_by_last_song_letter(last: last_song_name)

    @playlist
  end

  private

  def insert_first_song(first_song_name = nil)
    first_song = get_first_song(first_song_name)
    @playlist << first_song
    @memory.delete(first_song)
  end

  def get_first_song(first_song_name)
    return @memory.detect { |s| s.name == first_song_name } if first_song_name
    @memory[0]
  end

  def order_by_last_song_letter(last:)
    @get_next_song = true
    while @get_next_song
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
        @get_next_song = false if song == last
      else
        @get_next_song = false
      end
    end

    @playlist
  end

  def next_song
    @memory.detect{ |s| s.name[0] == @playlist.last.name[-1] }
  end
end
