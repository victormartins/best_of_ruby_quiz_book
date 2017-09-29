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
    [@first_song] + @memory
  end

  private

  def extract_first_song(first_song_name)
    @memory.delete(first_song_name)
  end

  def order_by_last_song_letter
    result = []
    first_iteration = true

    while(@memory.any?) do
      @first_song = result[-1] unless first_iteration
      match_song = @memory.select { |song| song[0].downcase == @first_song[-1].downcase  }
      result << @memory.slice!(@memory.find_index(match_song[0]))

      if @memory.length == 1
        result << @memory.pop
      end
      first_iteration = false
    end

    @memory = result.flatten
  end
end
