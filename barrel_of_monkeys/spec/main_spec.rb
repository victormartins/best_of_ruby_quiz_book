require_relative './../main'

RSpec.describe Main do
  let(:songs) { [] }
  subject { described_class.new(songs: songs) }

  describe '#playlist' do
    it 'returns a collection' do
      expect(subject.playlist).to eq([])
    end

    context 'when I pass a collection of songs' do
      let(:songs) { ['foo'] }

      it 'want my playlist to contain the songs of that collection' do
        expect(subject.playlist).to include('foo')
      end
    end
  end
end
