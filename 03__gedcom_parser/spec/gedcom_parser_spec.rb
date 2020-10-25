require 'gedcom_parser'

RSpec.describe GedcomParser do
  let(:small_sample_gemdcom_path) {"#{__dir__}/sample_data/small_sample.gedcom" }
  let(:small_sample_xml) { File.read("#{__dir__}/sample_data/small_sample.xml") }

  it 'Parses gedcom data correctly' do
    result = subject.call(input_file: small_sample_gemdcom_path)
    expect(result).to eql(small_sample_xml)
  end

  context 'When the file does not exist' do
    it 'raises an exception' do
      expect { subject.call(input_file: 'will_fail') }.to raise_error(
        GedcomParser::Error,
        'File not found: will_fail'
      )
    end
  end
end
