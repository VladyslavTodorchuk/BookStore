require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'shipping' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:user) }
    end
  end
end
