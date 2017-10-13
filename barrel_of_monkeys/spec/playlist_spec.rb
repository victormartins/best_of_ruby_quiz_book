require 'bigdecimal'
require_relative '../playlist'
require_relative '../song'

RSpec.describe Playlist do
  describe '#duration' do
    it 'returns the sum of the duration of all songs' do
      playlist = Playlist.new
      playlist << Song.new(name: 'foo', duration: '10')
      playlist << Song.new(name: 'bar', duration: '20')
      expect(playlist.duration ).to eq(BigDecimal.new('30'))
    end
  end
end
