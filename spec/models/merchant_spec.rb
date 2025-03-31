require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
end
