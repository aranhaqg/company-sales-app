class AddSaleReportToPurchase < ActiveRecord::Migration[8.0]
  def change
    add_reference :purchases, :sale_report
  end
end
