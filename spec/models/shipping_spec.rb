require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'shipping' do
    context 'when validations' do
      it { is_expected.to allow_values(FFaker::Name.first_name).for(:first_name) }
      it { is_expected.to allow_values(FFaker::Name.first_name).for(:last_name) }
      it { is_expected.to allow_values('+919367788755', '8989829304', '+16308520397', '786-307-3615').for(:phone) }
      it { is_expected.to allow_values(FFaker::AddressUK.country).for(:country) }
      it { is_expected.to allow_values(FFaker::Address.city).for(:city) }
      it { is_expected.to allow_values(FFaker::AddressUA.zip_code).for(:zip) }
      it { is_expected.to allow_values(FFaker::Address.street_address).for(:address) }
    end

    context 'when not validations' do
      it { is_expected.not_to allow_values('A' * Constants::VALIDATES_NAME_LENGTH_MAX.next).for(:first_name) }
      it { is_expected.not_to allow_values('A' * Constants::VALIDATES_NAME_LENGTH_MAX.next).for(:last_name) }
      it { is_expected.not_to allow_values('789', '123765', '1-1-1', '+982').for(:phone) }
      it { is_expected.not_to allow_values('A' * Constants::VALIDATES_TITLE_LENGTH_MAX.next).for(:country) }
      it { is_expected.not_to allow_values('A' * Constants::VALIDATES_TITLE_LENGTH_MAX.next).for(:city) }
      it { is_expected.not_to allow_values('1' * Constants::VALIDATES_ZIP_LENGTH_MAX.next).for(:zip) }
      it { is_expected.not_to allow_values('A' * Constants::VALIDATES_TITLE_LENGTH_MAX.next).for(:address) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:user) }
    end
  end
end
