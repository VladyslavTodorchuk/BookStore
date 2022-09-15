require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'review' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_presence_of(:rating) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:book) }
      it { is_expected.to belong_to(:user) }
    end
  end
end
