# /Users/pi/Projects/ruby/company-sales-app/app/services/purchases_file_parser_service.rb

class PurchasesFileParserService
    def initialize(file_path)
        @file_path = file_path
    end

    def call
        raise "File not found" unless File.exist?(@file_path)
        raise "Invalid data format" if File.foreach(@file_path).count <= 1

        ActiveRecord::Base.transaction do
            purchases = []
            sale_report = SaleReport.create(file_path: @file_path)

            File.foreach(@file_path).with_index do |line, index|
                next if index.zero? # Skip the file header

                purchases << parse_line(line, sale_report)
            end

            sale_report.total_gross_income_cents = purchases.pluck(:total_price_cents).sum
            sale_report.save
        end
    end

    private

    def parse_line(line, sale_report)
        data = line.strip.split("\t")

        purchaser_name = data[0]
        item_description = data[1]
        item_price = data[2].to_f
        purchase_count = data[3].to_i
        merchant_address = data[4]
        merchant_name = data[5]

        purchaser = Purchaser.find_or_create_by(name: purchaser_name)

        product = Product.find_or_create_by(description: item_description)
        product.price_cents = format_price_cents(item_price)
        product.save if product.changed?

        merchant = Merchant.find_or_create_by(name: merchant_name)
        merchant.address = merchant_address
        merchant.save if merchant.changed?

        total_price_cents = purchase_count * product.price_cents


        purchase = Purchase.create!(
            purchaser: purchaser,
            product: product,
            merchant: merchant,
            count: purchase_count,
            sale_report: sale_report,
            total_price_cents: total_price_cents
        )

        purchase
    rescue StandardError => e
        Rails.logger.error("Failed to parse line: #{line}.")
        raise "Failed to parse line"
    end

    def format_price_cents(price)
        price_formatted = "%.2f" % price
        price_cents = price_formatted.delete(".").to_i
        price_cents
    end
end
