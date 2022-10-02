require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'review' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_presence_of(:rating) }
      it { is_expected.to validate_presence_of(:verified) }
      it { is_expected.to allow_values('a' * Constants::VALIDATES_TITLE_LENGTH_MAX).for(:title) }
      it { is_expected.to allow_values('a' * Constants::VALIDATES_TEXT_LENGTH_MAX).for(:body) }
      it { is_expected.to allow_values(1, 2, 3, 4, 5).for(:rating) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:book) }
      it { is_expected.to belong_to(:user) }
    end
  end
end
