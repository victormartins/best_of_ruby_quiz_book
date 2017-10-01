require_relative '../library_loader'

RSpec.describe LibraryLoader do
  describe 'validating the path' do
    it 'returns an error if the file does not exist' do
      expect{described_class.new(xml_path: 'foo.xml')}.to raise_error('File Not Found!')
    end
  end

  describe 'Reading the XML file by default' do
    subject { described_class.new.call}

    it 'returns an array' do
      expect(subject).to be_kind_of(Array)
    end
  end
end
