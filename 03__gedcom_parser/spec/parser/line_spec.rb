RSpec.describe GedcomParser::Parser::Line do
  context 'When the line is an ID' do
    let(:line) { File.readlines("#{__dir__}/../sample_data/small_sample.gedcom").first }

    it 'Returns a line with an ID' do
      expect(subject.call(line)).to match({
        attribute:    'I1',
        tag:  'INDI',
        level: 0
      })
    end
  end

  context 'When the line does not have an ID' do
    let(:line) { File.readlines("#{__dir__}/../sample_data/small_sample.gedcom")[1] }

    it 'Returns a line without the ID' do
      expect(subject.call(line)).to match({
        value: 'Jamis Gordon /Buck/',
        tag:   'NAME',
        level: 1
      })
    end
  end
end
