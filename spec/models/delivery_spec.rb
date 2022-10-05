require 'rails_helper'

RSpec.describe Delivery, type: :model do
  context 'when validations' do
    it { is_expected.to validate_presence_of(:delivery_method) }
  end

  context 'when associations' do
    it { is_expected.to have_many(:orders).dependent(:nullify) }
  end
end
