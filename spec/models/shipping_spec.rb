require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'shipping' do
    context 'when associations' do
      it { is_expected.to belong_to(:user) }
    end
  end
end
