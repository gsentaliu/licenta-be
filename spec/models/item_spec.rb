require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to belong_to(:exam) }
  it { is_expected.to validate_presence_of(:name) }
end