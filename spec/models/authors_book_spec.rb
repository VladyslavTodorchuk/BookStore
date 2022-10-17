RSpec.describe AuthorsBook, type: :model do
  describe 'authors_book' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:book) }
      it { is_expected.to validate_presence_of(:author) }
    end

    context 'when associations' do
      it { is_expected.to belong_to(:author) }
      it { is_expected.to belong_to(:book) }
    end
  end
end
