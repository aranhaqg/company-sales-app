require 'rails_helper'

RSpec.describe PurchasesFileParserService, type: :service do
  let(:file_path) { 'spec/fixtures/files/example_input_2.tab' }
  let(:service) { described_class.new(file_path) }

  describe '#call' do
    context 'when the file does not exist' do
      let(:file_path) { 'non_existent_file.txt' }

      it 'raises a "File not found" error' do
        expect { service.call }.to raise_error(RuntimeError, 'File not found')
      end
    end

    context 'when the file exists and contains valid data' do
      before do
        # Create a sample file with valid data
        File.open(file_path, 'w') do |file|
          file.puts '"purchaser name"\t"item description"\t"item price"\t"purchase count"\t"merchant address"\t"merchant name"'
          file.puts "John Doe\tItem A\t10.00\t2\t123 Street\tMerchant A"
        end
      end

      after do
        File.delete(file_path) if File.exist?(file_path)
      end

      it 'processes the file and creates purchases' do
        expect { service.call }.to change { SaleReport.count }.by(1)
          .and change { Purchaser.count }.by(1)
          .and change { Product.count }.by(1)
          .and change { Merchant.count }.by(1)
          .and change { Purchase.count }.by(1)

        sale_report = SaleReport.last
        purchaser = Purchaser.last
        product = Product.last
        merchant = Merchant.last
        purchase = Purchase.last

        expect(sale_report.file_path).to eq(file_path)
        expect(sale_report.total_gross_income_cents).to eq(2000)

        expect(purchaser.name).to eq('John Doe')

        expect(product.description).to eq('Item A')
        expect(product.price_cents).to eq(1000)

        expect(merchant.name).to eq('Merchant A')
        expect(merchant.address).to eq('123 Street')

        expect(purchase.purchaser).to eq(purchaser)
        expect(purchase.product).to eq(product)
        expect(purchase.merchant).to eq(merchant)
        expect(purchase.count).to eq(2)
        expect(purchase.total_price_cents).to eq(2000)
      end
    end

    context 'when the file contains invalid data' do
      before do
        # Create a sample file with invalid data
        File.open(file_path, 'w') do |file|
          file.puts "Invalid\tData"
        end

        allow(Rails.logger).to receive(:error)
      end

      after do
        File.delete(file_path) if File.exist?(file_path)
      end

      it 'raises a "Invalid data format" error' do
        expect { service.call }.to raise_error(RuntimeError, 'Invalid data format')
      end
    end

    context 'when a line fails to parse' do
      before do
        # Create a sample file with one valid line and one invalid line
        File.open(file_path, 'w') do |file|
          file.puts '"purchaser name"\t"item description"\t"item price"\t"purchase count"\t"merchant address"\t"merchant name"'
          file.puts "John Doe\tItem A\t10.00\t2\t123 Street\tMerchant A"
          file.puts "Invalid\tData"
        end

        allow(Rails.logger).to receive(:error)
      end

      after do
        File.delete(file_path) if File.exist?(file_path)
      end

      it 'logs an error and ' do
        expect { service.call }.to raise_error(RuntimeError, 'Failed to parse line')
        expect(Rails.logger).to have_received(:error).with("Failed to parse line: Invalid\tData\n.")
      end
    end
  end
end
