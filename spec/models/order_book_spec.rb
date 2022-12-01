RSpec.describe OrderBook, type: :model do
  context 'when associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:book) }
  end
end
