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
      end

      it 'displays 1' do
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

      it 'displays 2' do
        expect(subject.call(2)).to eql(
          " -- \n" \
          "   |\n" \
          "   |\n" \
          " -- \n" \
          "|   \n" \
          "|   \n" \
          " -- \n" \
        )
      end

      it 'displays 3' do
        expect(subject.call(3)).to eql(
          " -- \n" \
          "   |\n" \
          "   |\n" \
          " -- \n" \
          "   |\n" \
          "   |\n" \
          " -- \n" \
        )
      end

      it 'displays 4' do
        expect(subject.call(4)).to eql(
          "    \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
          "   |\n" \
          "   |\n" \
          "    \n" \
        )
      end

      it 'displays 5' do
        expect(subject.call(5)).to eql(
          " -- \n" \
          "|   \n" \
          "|   \n" \
          " -- \n" \
          "   |\n" \
          "   |\n" \
          " -- \n" \
        )
      end

      it 'displays 6' do
        expect(subject.call(6)).to eql(
          " -- \n" \
          "|   \n" \
          "|   \n" \
          " -- \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
        )
      end

      it 'displays 7' do
        expect(subject.call(7)).to eql(
          " -- \n" \
          "   |\n" \
          "   |\n" \
          " -- \n" \
          "   |\n" \
          "   |\n" \
          "    \n" \
        )
      end

      it 'displays 8' do
        expect(subject.call(8)).to eql(
          " -- \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
        )
      end

      it 'displays 9' do
        expect(subject.call(9)).to eql(
          " -- \n" \
          "|  |\n" \
          "|  |\n" \
          " -- \n" \
          "   |\n" \
          "   |\n" \
          " -- \n" \
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

      it 'A sequence of 111' do
        expect(subject.call(111)).to eql(
          "              \n" \
          "   |    |    |\n" \
          "   |    |    |\n" \
          "              \n" \
          "   |    |    |\n" \
          "   |    |    |\n" \
          "              \n" \
        )
      end

      it 'A sequence of 1234567890' do
        expect(subject.call(1234567890)).to eql(
          "      --   --        --   --   --   --   --   -- \n" \
          "   |    |    | |  | |    |       | |  | |  | |  |\n" \
          "   |    |    | |  | |    |       | |  | |  | |  |\n" \
          "      --   --   --   --   --   --   --   --   -- \n" \
          "   | |       |    |    | |  |    | |  |    | |  |\n" \
          "   | |       |    |    | |  |    | |  |    | |  |\n" \
          "      --   --        --   --        --   --   -- \n" \
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
          " - \n"
        )
      end
    end

    context 'When the scale is 3' do
      let(:scale_factor) { 3 }

      it 'displays 0 on the scale of 3' do
        expect(subject.call(0)).to eql(
          " --- \n" \
          "|   |\n" \
          "|   |\n" \
          "|   |\n" \
          " --- \n" \
          "|   |\n" \
          "|   |\n" \
          "|   |\n" \
          " --- \n"
        )
      end
    end
  end

  describe 'It can show different styles' do
    context 'When changing the style' do
      subject { described_class.new(dash: '=', pipe: '‖') }

      it 'displays the digits with the new style' do
        expect(subject.call(1234567890)).to eql(
          "      ==   ==        ==   ==   ==   ==   ==   == \n" \
          "   ‖    ‖    ‖ ‖  ‖ ‖    ‖       ‖ ‖  ‖ ‖  ‖ ‖  ‖\n" \
          "   ‖    ‖    ‖ ‖  ‖ ‖    ‖       ‖ ‖  ‖ ‖  ‖ ‖  ‖\n" \
          "      ==   ==   ==   ==   ==   ==   ==   ==   == \n" \
          "   ‖ ‖       ‖    ‖    ‖ ‖  ‖    ‖ ‖  ‖    ‖ ‖  ‖\n" \
          "   ‖ ‖       ‖    ‖    ‖ ‖  ‖    ‖ ‖  ‖    ‖ ‖  ‖\n" \
          "      ==   ==        ==   ==        ==   ==   == \n"
        )
      end
    end

    context 'When changing the style' do
      subject { described_class.new(dash: '🀫', pipe: '🀫', space: ' ') }
      it 'displays the digits with the new style' do
        expect(subject.call(1234567890)).to eql(
          "      🀫🀫   🀫🀫        🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫 \n" \
          "   🀫    🀫    🀫 🀫  🀫 🀫    🀫       🀫 🀫  🀫 🀫  🀫 🀫  🀫\n" \
          "   🀫    🀫    🀫 🀫  🀫 🀫    🀫       🀫 🀫  🀫 🀫  🀫 🀫  🀫\n" \
          "      🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫   🀫🀫 \n" \
          "   🀫 🀫       🀫    🀫    🀫 🀫  🀫    🀫 🀫  🀫    🀫 🀫  🀫\n" \
          "   🀫 🀫       🀫    🀫    🀫 🀫  🀫    🀫 🀫  🀫    🀫 🀫  🀫\n" \
          "      🀫🀫   🀫🀫        🀫🀫   🀫🀫        🀫🀫   🀫🀫   🀫🀫 \n"
        )
      end
    end
  end
end
