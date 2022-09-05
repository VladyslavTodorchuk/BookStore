require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'books' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_presence_of(:price) }
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
    end
  end
end
