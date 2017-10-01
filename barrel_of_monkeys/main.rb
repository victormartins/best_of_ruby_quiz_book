class Main
  def initialize(library:)
    @memory = library.dup
  end

  def playlist(first_song_name: nil)
    return @memory if @memory.empty?

    @first_song = if first_song_name
      extract_first_song(first_song_name)
    else
      @memory[0]
    end

    order_by_last_song_letter
    return [@first_song] + @memory if first_song_name
    @memory
  end

  private

  def extract_first_song(first_song_name)
    @memory.delete(first_song_name)
  end

  def order_by_last_song_letter
    @memory.sort!
  end
end
