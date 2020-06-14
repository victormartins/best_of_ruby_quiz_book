require 'mad_lib'

RSpec.describe MadLib do
  subject { described_class.new(template: template) }
  context 'When we initialize with a valid template' do
    context 'When the template has a single question' do
      let(:template) do
        'Our favorite language is ((a language)).'
      end

      it 'returns a single question' do
        expect(subject.questions).to eql(['Please enter a language:'])
      end

      it 'replaces the awnser correctly' do
        answers = ['Ruby']
        expect(subject.answers(answers)).to eql('Our favorite language is Ruby.')
      end
    end

    context 'When the template has a two questions' do
      let(:template) do
        'Our favorite language is ((a language)) and our favorite book is ((a book)).'
      end

      xit 'returns a two questions' do
        expect(subject.questions).to eql([
            'Please enter a language:',
            'Please enter a book:'
          ])
      end

      xit 'replaces the awnsers correctly' do
        answers = ['Ruby', 'Refactoring Ruby Edition']
        expect(subject.answers(answers)).to eql(
          'Our favorite language is Ruby and our favorite book is Refactoring Ruby Edition.'
        )
      end
    end
  end
end
