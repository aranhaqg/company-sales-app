require 'rails_helper'

RSpec.describe "SaleReports", type: :request do
  describe "GET /new" do
    it "renders the new template" do
      get new_sale_report_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Upload Sales Data")
    end
  end

  describe "POST /create" do
    let(:file_path) { Rails.root.join('tmp', 'example_input.tab') }
    let(:uploaded_file) { fixture_file_upload(file_path, 'text/tab-separated-values') }

    before do
      # Create a sample file for testing
      File.open(file_path, 'w') do |file|
        file.puts '"purchaser name"\t"item description"\t"item price"\t"purchase count"\t"merchant address"\t"merchant name"'
        file.puts "John Doe\tItem A\t10.00\t2\t123 Street\tMerchant A"
      end
    end

    after do
      File.delete(file_path) if File.exist?(file_path)
    end

    context "when a file is uploaded successfully" do
      it "processes the file and redirects to the index page" do
        expect {
          post sale_reports_path, params: { sale_report: { file: uploaded_file } }
        }.to change(SaleReport, :count).by(1)

        expect(response).to redirect_to(sale_reports_path)
        follow_redirect!
        expect(response.body).to include("File processed successfully.")
      end
    end

    context "when no file is uploaded" do
      it "redirects to the new page with an alert" do
        post sale_reports_path, params: { sale_report: { file: nil } }

        expect(response).to redirect_to(new_sale_report_path)
        follow_redirect!
        expect(response.body).to include("Please upload a file.")
      end
    end

    context "when an error occurs during file processing" do
      before do
        allow_any_instance_of(PurchasesFileParserService).to receive(:call).and_raise(StandardError, "Test error")
      end

      it "redirects to the index page with an alert" do
        post sale_reports_path, params: { sale_report: { file: uploaded_file } }

        expect(response).to redirect_to(sale_reports_path)
        follow_redirect!
        expect(response.body).to include("Error processing file: Test error")
      end
    end
  end

  describe "GET /index" do
    let!(:sale_report1) { create(:sale_report, total_gross_income_cents: 1000) }
    let!(:sale_report2) { create(:sale_report, total_gross_income_cents: 2000) }

    it "renders the index template and displays sale reports" do
      get sale_reports_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Sale Reports")
      expect(response.body).to include("$10.00") # SaleReport 1 gross income
      expect(response.body).to include("$20.00") # SaleReport 2 gross income
      expect(response.body).to include("$30.00") # Total all-time gross income
    end
  end
end
