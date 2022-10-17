RSpec.describe Author, type: :model do
  describe 'author' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
    end

    context 'when associations' do
      it { is_expected.to have_many(:authors_books).dependent(:destroy) }
      it { is_expected.to have_many(:books).through(:authors_books) }
    end
  end
end
