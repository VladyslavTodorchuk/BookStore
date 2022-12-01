RSpec.describe Coupon, type: :model do
  context 'when associations' do
    it { is_expected.to belong_to(:order).optional(true) }
  end
end
