FactoryBot.define do
  factory :sale_report do
    file_path { 'spec/fixtures/files/example_input.tab' }
    total_gross_income_cents { 0 }
  end
end
