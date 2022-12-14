RSpec.describe BooksCategory, type: :model do
  describe 'books_categories' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:book) }
      it { is_expected.to validate_presence_of(:category) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:category) }
      it { is_expected.to belong_to(:book) }
    end
  end
end
