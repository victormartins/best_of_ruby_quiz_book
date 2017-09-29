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

    context 'when I pass a library songs' do
      let(:library) { ['z','Klucks','Focks','Suck'] }

      it 'contains the songs of that library' do
        expect(subject.playlist).to include('Klucks')
      end

      it 'allows us to define the name of the first song' do
        expect(subject.playlist(first_song_name: 'Focks')).to start_with('Focks')
      end

      xit 'returns songs ordered by the last letter' do
        expect(subject.playlist).to be(['Focks', 'Suck', 'Klucks'])
      end
    end
  end
end
