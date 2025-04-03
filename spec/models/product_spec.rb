require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price_cents) }
  it { should validate_numericality_of(:price_cents).is_greater_than_or_equal_to(0) }
end
