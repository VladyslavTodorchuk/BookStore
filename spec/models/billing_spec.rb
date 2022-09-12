require 'rails_helper'

RSpec.describe Billing, type: :model do
  describe 'billing' do
    context 'when associations' do
      it { is_expected.to belong_to(:user) }
    end
  end
end
