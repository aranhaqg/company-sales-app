require 'rails_helper'

RSpec.describe SaleReportsHelper, type: :helper do
  describe '#format_currency' do
    it 'formats cents into a currency string' do
      expect(helper.format_currency(12345)).to eq('$123.45')
    end

    it 'formats zero cents correctly' do
      expect(helper.format_currency(0)).to eq('$0.00')
    end

    it 'handles negative values correctly' do
      expect(helper.format_currency(-12345)).to eq('-$123.45')
    end
  end
end
