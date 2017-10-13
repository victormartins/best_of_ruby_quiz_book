require_relative './../main'
require_relative './../song'

RSpec.describe Main do
  describe '#playlist' do
    it 'returns an Array' do
      expect(subject.playlist).to be_kind_of(Playlist)
    end

    context 'when I pass a library of songs' do
      subject { described_class.new(library: library) }

      let(:library) do
        [
          Song.new(name: 'c_song_d'),
          Song.new(name: 'e_song_f'),
          Song.new(name: 'a_song_b'),
          Song.new(name: 'd_song_e'),
          Song.new(name: 'b_song_c')
        ]
      end

      it 'does not change the injected library' do
        expect(subject.playlist.object_id).to_not eq(library.object_id)
      end

      it 'contains the songs of that library' do
        expect(subject.playlist.map(&:name)).to include('c_song_d')
      end

      it 'returns songs ordered by the last letter' do
        expected_array = ['a_song_b', 'b_song_c', 'c_song_d', 'd_song_e', 'e_song_f']
        expect(subject.playlist(first_song_name: 'a_song_b').map(&:name)).to eq(expected_array)
      end

      context 'if I set the first song name' do
        it 'returns a playlist starting at that song name' do
          expect(subject.playlist(first_song_name: 'c_song_d').map(&:name)).to start_with('c_song_d')
        end

        it 'links all other possible songs with that music' do
          expected_array = ['c_song_d', 'd_song_e', 'e_song_f']
          expect(subject.playlist(first_song_name: 'c_song_d').map(&:name)).to eq(expected_array)
        end

        it 'raises an error if the first song was not found'

        context 'and a last song name' do
          it 'connects the first and the last song name' do
            expect(
              subject.playlist(
                first_song_name: 'b_song_c',
                last_song_name: 'd_song_e'
              ).map(&:name)
            ).to eq([
                'b_song_c',
                'c_song_d',
                'd_song_e'
              ])
          end
        end
      end

      context 'when passing two ordered songs' do
        let(:library) do
          [
            Song.new(name: 'az'),
            Song.new(name: 'za')
          ]
        end

        it 'returns only two songs' do
          expect(subject.playlist.map(&:name)).to eq(['az','za'])
        end
      end

      context 'when passing two unordered songs' do
        let(:library) do
          [
            Song.new(name: 'az'),
            Song.new(name: 'za')
          ]
        end

        it 'returns only two songs' do
          expect(subject.playlist(first_song_name: 'za').map(&:name)).to eq(['za', 'az'])
        end
      end
    end

    context 'when I dont pass a library of songs' do
      it 'I get songs from the xml file' do
        expect(subject.playlist.first.name).to eq('Caught Up In You')
      end

      it 'returns the same playlist even if called twice' do
        playlist_1 = subject.playlist.map(&:name)
        playlist_2 = subject.playlist.map(&:name)
        expect(playlist_1).to eq(playlist_2)
      end
    end

    context 'when the first song does not relate no any other song' do
      it '____DEFINE_BEHAVIOUR___'
    end
  end
end
