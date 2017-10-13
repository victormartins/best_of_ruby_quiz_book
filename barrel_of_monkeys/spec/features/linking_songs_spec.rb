require_relative './../../main'
require_relative './../../song'

RSpec.describe Main do
  describe 'linking songs' do
    subject { described_class.new(library: library) }

    describe 'Ignoring uppercases' do
      let(:library) do
        [
          Song.new(name: 'song_A'),
          Song.new(name: 'a_song')
        ]
      end

      it 'links the two songs together' do
        expect(subject.playlist.map(&:name)).to eq(['song_A', 'a_song'])
      end
    end
  end
end
