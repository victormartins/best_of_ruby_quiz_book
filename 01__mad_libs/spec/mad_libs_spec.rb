require '00_mad_lib'

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

      it 'replaces the answer correctly' do
        answers = ['Ruby']
        expect(subject.answers(answers)).to eql('Our favorite language is Ruby.')
      end
    end

    context 'When the template has a two questions' do
      let(:template) do
        'Our favorite language is ((a language)) and our favorite book is ((a book)).'
      end

      it 'returns a two questions' do
        expect(subject.questions).to eql(
          [
            'Please enter a language:',
            'Please enter a book:'
          ]
        )
      end

      it 'replaces the answers correctly' do
        answers = ['Ruby', 'Refactoring Ruby Edition']
        expect(subject.answers(answers)).to eql(
          'Our favorite language is Ruby and our favorite book is Refactoring Ruby Edition.'
        )
      end

      it 'does not mutate the input' do
        answers = ['Ruby', 'Refactoring Ruby Edition']

        subject.answers(answers)

        expect(answers).to eql(['Ruby', 'Refactoring Ruby Edition'])
      end
    end

    context 'When the template has a two questions an one is in the start' do
      let(:template) do
        '((a language)) is our favorite language and our favorite book is ((a book)).'
      end

      it 'returns a two questions' do
        expect(subject.questions).to eql(
          [
            'Please enter a language:',
            'Please enter a book:'
          ]
        )
      end

      it 'replaces the answers correctly' do
        answers = ['Ruby', 'Refactoring Ruby Edition']

        expect(subject.answers(answers)).to eql(
          'Ruby is our favorite language and our favorite book is Refactoring Ruby Edition.'
        )
      end
    end

    context 'When the template has a three questions' do
      let(:template) do
        'I had a ((an adjective)) sandwich for lunch today. ' \
          'It dripped all over my ((a body part)) and ((a noun)).'
      end

      it 'returns a three questions' do
        expect(subject.questions).to eql(
          [
            'Please enter an adjective:',
            'Please enter a body part:',
            'Please enter a noun:',
          ]
        )
      end

      it 'replaces the answers correctly' do
        answers = ['smelly', 'big toe', 'bathtub']
        expect(subject.answers(answers)).to eql(
          'I had a smelly sandwich for lunch today. ' \
          'It dripped all over my big toe and bathtub.'
        )
      end
    end

    context 'When the template is multiline' do
      let(:template) do
        "Our favorite language is ((a language))\n" \
          'and our favorite book is ((a book)).'
      end

      it 'returns the right amount of questions' do
        expect(subject.questions).to eql(
          [
            'Please enter a language:',
            'Please enter a book:'
          ]
        )
      end

      it 'replaces the answers correctly' do
        answers = ['Ruby', 'Refactoring Ruby Edition']

        expect(subject.answers(answers)).to eql(
          "Our favorite language is Ruby\n" \
            'and our favorite book is Refactoring Ruby Edition.'
        )
      end
    end

    context 'When the template reuses placeholders' do
      let(:template) do
        'Our favorite drink is ((drink:a drink)). ' \
        'We think ((drink)) goes well with ((a dish)).'
      end

      it 'returns a two questions' do
        expect(subject.questions).to eql(
          [
            'Please enter a drink:',
            'Please enter a dish:'
          ]
        )
      end

      it 'replaces the answer correctly' do
        answers = ['Red Wine', "Shepperd's Pie"]

        expect(subject.answers(answers)).to eql(
          'Our favorite drink is Red Wine. ' \
          "We think Red Wine goes well with Shepperd's Pie."
        )
      end
    end
  end
end
