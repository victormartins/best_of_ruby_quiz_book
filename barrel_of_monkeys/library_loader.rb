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
    artists.each do |artist|
      artist_name = artist['name']

      songs_from(artist).each do |xml_song|
        @result << create_song(xml_song, artist_name)
      end
    end

    @result
  end

  private

  def artists
    xml_data.css('Artist')
  end

  def songs_from(artist)
    artist.css('Song')
  end

  def xml_data
    @xml_data ||= File.open(@source_path) { |f| Nokogiri::XML(f) }
  end

  def create_song(xml_song, artist_name)
    song          = Song.new(name: xml_song['name'])
    song.id       = xml_song['id']
    song.duration = xml_song['duration']
    song.artist   = artist_name
    song
  end
end
