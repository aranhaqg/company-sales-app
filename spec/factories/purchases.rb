FactoryBot.define do
  factory :purchase do
    purchaser
    item { association :product }
    merchant
    count { 2 }
    total_price_cents { 200 }
    sale_report
  end
end