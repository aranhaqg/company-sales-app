class SaleReportsController < ApplicationController
  def new
    @sale_report = SaleReport.new
  end

  def create
    uploaded_file = params[:sale_report][:file]

    if uploaded_file.nil?
      flash[:alert] = "Please upload a file."
      redirect_to new_sale_report_path and return
    end

    # Use Tempfile to securely handle the uploaded file
    Tempfile.create(['sale_report', File.extname(uploaded_file.original_filename)]) do |tempfile|
      tempfile.binmode
      tempfile.write(uploaded_file.read)
      tempfile.flush

      begin
        PurchasesFileParserService.new(tempfile.path).call
        flash[:notice] = "File processed successfully."
      rescue StandardError => e
        flash[:alert] = "Error processing file: #{e.message}"
      end
    end

    redirect_to sale_reports_path
  end

  def index
    @sale_reports = SaleReport.all
    @total_all_time_gross_income_cents = SaleReport.first&.total_all_time_gross_income_cents || 0
  end
end
