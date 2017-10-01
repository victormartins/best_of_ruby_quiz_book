require 'pathname'
require 'nokogiri'
require_relative './song'

class LibraryLoader
  def initialize(xml_path: 'data/SongLibrary.xml')
    @source_path = Pathname.new(xml_path)
    raise 'File Not Found!' unless @source_path.exist?
  end

  def call
    @result = []
    @xml_data = File.open(@source_path) { |f| Nokogiri::XML(f) }
    artists.each do |artist|
      artist_name = artist['name']
      songs_from(artist).each do |xml_song|
        song          = Song.new(xml_song['name'])
        song.id       = xml_song['id']
        song.duration = xml_song['duration']
        song.artist   = artist_name
        @result << song
      end
    end

    @result
  end

  private

  def artists
    @xml_data.css('Artist')
  end

  def songs_from(artist)
    artist.css('Song')
  end
end
