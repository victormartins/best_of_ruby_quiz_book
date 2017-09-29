require_relative './../main'

RSpec.describe Main do
  subject { described_class.new }

  describe '#playlist' do
    it 'returns a collection' do
      expect(subject.playlist).to eq([])
    end
  end
end
