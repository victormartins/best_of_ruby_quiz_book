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
      let(:library) { ['K1luckf','F2ocks','S3uck'] }

      it 'contains the songs of that library' do
        expect(subject.playlist).to include('K1luckf')
      end

      it 'allows us to define the name of the first song' do
        expect(subject.playlist(first_song_name: 'F2ocks')).to start_with('F2ocks')
      end

      it 'returns songs ordered by the last letter' do
        expect(subject.playlist(first_song_name: 'F2ocks')).to eq(['F2ocks', 'S3uck', 'K1luckf'])
      end
    end

    context 'when passing two ordered songs' do
      let(:library) { ['az','za'] }

      it 'returns only two songs' do
        pending('There is a bug where we get a copy of a song.')
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
