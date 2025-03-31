require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should validate_presence_of(:count) }
  it { should validate_numericality_of(:count).is_greater_than(0)}

  it { should validate_presence_of(:purchaser) }
  it { should validate_presence_of(:item) }
  it { should validate_presence_of(:merchant) }
end
