RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'author' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'with associations' do
      it { is_expected.to have_one(:billing) }
      it { is_expected.to have_one(:shipping) }
      it { is_expected.to have_many(:reviews).dependent(:nullify) }
    end
  end
end
