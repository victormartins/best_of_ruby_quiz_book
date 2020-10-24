require 'gedcom_parser'

RSpec.describe GedcomParser do
  let(:small_sample_gemdcom) { File.read("#{__dir__}/sample_data/small_sample.gedcom") }
  let(:small_sample_xml) { File.read("#{__dir__}/sample_data/small_sample.xml") }
  it 'Parses gedcom data correctly' do
    result = subject.call(input: small_sample_gemdcom)
    expect(result).to eql(small_sample_xml)
  end
end
