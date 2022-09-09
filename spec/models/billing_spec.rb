require 'rails_helper'

RSpec.describe Billing, type: :model do
  describe 'billing' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:zip) }
      it { is_expected.to validate_presence_of(:phone) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:country) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:user) }
    end
  end
end
