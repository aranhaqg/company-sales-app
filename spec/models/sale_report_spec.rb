require 'rails_helper'

RSpec.describe SaleReport, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:file_path) }
  end

  describe 'after_save callback' do
    let!(:sale_report1) { create(:sale_report, total_gross_income_cents: 1000) }
    let!(:sale_report2) { create(:sale_report, total_gross_income_cents: 2000) }

    it 'updates the total_all_time_gross_income_cents cache after saving a record' do
      # Trigger the after_save callback by creating a new SaleReport
      create(:sale_report, total_gross_income_cents: 3000)

      # Reload the first SaleReport to check the updated cache
      sale_report1.reload

      expect(sale_report1.total_all_time_gross_income_cents).to eq(6000) # 1000 + 2000 + 3000
    end
  end
end
