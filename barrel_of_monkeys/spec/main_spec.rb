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

      it 'allows us to define the name of the first song' do
        expect(subject.playlist(first_song_name: 'a_song_b')).to start_with('a_song_b')
      end

      it 'returns songs ordered by the last letter' do
        expected_array = ['a_song_b', 'b_song_c', 'c_song_d', 'd_song_e', 'e_song_f']
        expect(subject.playlist(first_song_name: 'a_song_b')).to eq(expected_array)
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
