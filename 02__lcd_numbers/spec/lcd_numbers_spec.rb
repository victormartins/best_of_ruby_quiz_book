require '00_lcd_numbers'

RSpec.describe LCDNumbers do
  context 'When using default configurations' do
    describe 'Single Digits' do
      it 'displays 0' do
        expect(subject.call(0)).to eql(
          " -- \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
        )


        #       a = [
        #         '.xx.',
        #         '.--.',
        #         '.xx.'
        #       ]

        #       b = [
        #         '.yy.',
        #         '.00.',
        #         '.yy.'
        #       ]

        #       c = [
        #         '.zz.',
        #         '.11.',
        #         '.zz.'
        #       ]

        #       d = [
        #         '.ii.',
        #         '.HH.',
        #         '.ii.'
        #       ]


        #       puts
        #       puts
        #       puts '_' * 50

        #       puts a.zip(b).zip(c).map { |r| r.join(' ') }.join("\n")
        #       puts
        #       puts a.zip(b, c, d).map { |r| r.join(' ') }.join("\n")
      end

      xit 'displays 1' do
        expect(subject.call(1)).to eql(
          "    \n" \
          "   |\n" \
          "   |\n" \
          "    \n" \
          "   |\n" \
          "   |\n" \
          "    \n" \
        )
      end
    end

    describe 'Sequence of Digits' do
      it 'A sequence of zeros' do
        expect(subject.call('000')).to eql(
          " --   --   -- \n" \
          "|  | |  | |  |\n" \
          "|  | |  | |  |\n" \
          " --   --   -- \n" \
          "|  | |  | |  |\n" \
          "|  | |  | |  |\n" \
          " --   --   -- \n" \
        )
      end
    end
  end

  context 'When changing the scale' do
    subject { described_class.new(scale: scale_factor) }

    context 'When the scale is 1' do
      let(:scale_factor) { 1 }

      it 'displays 0 on the scale of 1' do
        expect(subject.call(0)).to eql(
          " - \n" \
          "| |\n" \
          " - \n" \
          "| |\n" \
          " - \n" \
        )
      end
    end
  end
end
