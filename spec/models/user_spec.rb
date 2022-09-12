RSpec.describe User, type: :model do
  describe 'author' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'with associations' do
      it 'has billing' do
        expect(user).to respond_to :billing
      end

      it 'has shipping' do
        expect(user).to respond_to :shipping
      end
    end
  end
end
