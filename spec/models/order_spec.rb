require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'order' do
    context 'when associations' do
      it { is_expected.to have_many(:order_books).dependent(:destroy) }
      it { is_expected.to have_many(:books).through(:order_books) }
    end
  end
end
