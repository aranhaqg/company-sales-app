module SaleReportsHelper
  # Formats a given amount in cents to a currency string (e.g., "$10.00")
  def format_currency(cents)
    number_to_currency(cents.to_f / 100.0)
  end
end
