RSpec.describe User, type: :model do
  describe 'author' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end
  end
end
