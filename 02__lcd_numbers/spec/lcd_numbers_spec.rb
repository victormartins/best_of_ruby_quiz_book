require '00_lcd_numbers'

RSpec.describe LCDNumbers do
  context 'When using default configurations' do
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
