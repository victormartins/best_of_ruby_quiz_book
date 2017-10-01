require_relative './../main'

RSpec.describe Main do
  let(:library) { [] }
  subject { described_class.new(library: library) }

  describe '#playlist' do
    it 'returns a collection' do
      expect(subject.playlist).to eq([])
    end

    it 'does not change the injected library' do
      expect(subject.playlist.object_id).to_not eq(library.object_id)
    end

    context 'when I pass a library of songs' do
      let(:library) { ['c_song_d','e_song_f' ,'a_song_b', 'd_song_e' ,'b_song_c'] }

      it 'contains the songs of that library' do
        expect(subject.playlist).to include('c_song_d')
      end

      it 'returns songs ordered by the last letter' do
        expected_array = ['a_song_b', 'b_song_c', 'c_song_d', 'd_song_e', 'e_song_f']
        expect(subject.playlist(first_song_name: 'a_song_b')).to eq(expected_array)
      end

      context 'if I set the first song name' do
        it 'returns a playlist starting at that song name' do
          expect(subject.playlist(first_song_name: 'c_song_d')).to start_with('c_song_d')
        end

        it 'links all other possible songs with that music' do
          expected_array = ['c_song_d', 'd_song_e', 'e_song_f']
          expect(subject.playlist(first_song_name: 'c_song_d')).to eq(expected_array)
        end

        it 'raises an error if the first song was not found'
      end
    end

    context 'when passing two ordered songs' do
      let(:library) { ['az','za'] }

      it 'returns only two songs' do
        expect(subject.playlist).to eq(['az','za'])
      end
    end

    context 'when passing two unordered songs' do
      let(:library) { ['az','za'] }

      it 'returns only two songs' do
        expect(subject.playlist(first_song_name: 'za')).to eq(['za', 'az'])
      end
    end

    context 'when the first song does not relate no any other song' do
      it '____DEFINE_BEHAVIOUR___'
    end
  end
end
