require 'rails_helper'

RSpec.describe Purchaser, type: :model do
  it { should validate_presence_of(:name) }
end
