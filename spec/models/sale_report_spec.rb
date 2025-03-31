require 'rails_helper'

RSpec.describe SaleReport, type: :model do
  it { should validate_presence_of(:file_path) }
end
