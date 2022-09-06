RSpec.describe User, type: :model do
<<<<<<< HEAD
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
=======
  pending "add some examples to (or delete) #{__FILE__}"
>>>>>>> 6b9ca2b (Add User modle)
end
