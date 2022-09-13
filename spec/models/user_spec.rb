RSpec.describe User, type: :model do
  describe 'author' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'with associations' do
      it { is_expected.to respond_to(:billing) }
      it { is_expected.to respond_to(:shipping) }
    end
  end
end
