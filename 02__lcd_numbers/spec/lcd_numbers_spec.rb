require '00_lcd_numbers'

RSpec.describe LCDNumbers do
  context 'When using default configurations' do
    it 'displays 0' do
      expect(subject.call(0)).to eql(
        " __ \n" \
        "|  |\n" \
        "|  |\n" \
        " -- \n" \
        "|  |\n" \
        "|  |\n" \
        " -- \n" \
      )
    end
  end
end
