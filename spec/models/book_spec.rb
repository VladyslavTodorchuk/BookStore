RSpec.describe Book, type: :model do
  describe 'books' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to allow_values(Constants::MIN_PRICE_IN_CENTS, Constants::MAX_PRICE_IN_CENTS).for(:price_cents) }
      it { is_expected.to validate_presence_of(:year_of_publication) }
      it { is_expected.to validate_presence_of(:quantity) }
      it { is_expected.to validate_presence_of(:materials) }
      it { is_expected.to validate_presence_of(:dimensions) }
    end

    context 'when associations' do
      it { is_expected.to have_many(:authors_books).dependent(:destroy) }
      it { is_expected.to have_many(:authors).through(:authors_books) }

      it { is_expected.to have_many(:books_categories).dependent(:destroy) }
      it { is_expected.to have_many(:categories).through(:books_categories) }

      it { is_expected.to have_many(:reviews).dependent(:destroy) }
      it { is_expected.to have_many_attached(:images) }
    end
  end
end
