require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject(:restaurant) { build(:restaurant, name: nil) }
  it { expect(restaurant.valid?).to be_falsey }
end
