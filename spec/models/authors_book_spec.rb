require 'rails_helper'

RSpec.describe AuthorsBook, type: :model do
  let(:book) { FactoryBot.create(:book) }
  let(:author) { FactoryBot.create(:author) }
  let(:authors_book) { FactoryBot.create(:authors_book, author_id: author.id, book_id: book.id) }

  describe '#add author for book (relationship)' do
    context 'when add (relationship)' do
      it 'add author for book' do
        authors_book
        expect(book.authors.size).to eq(1)
      end
    end
  end

  describe '#destroy author for book (relationship)' do
    context 'when destroy (relationship)' do
      it 'destroy (relationship)' do
        authors_book.destroy
        expect(authors_book.destroyed?).to eq(true)
      end
    end
  end
end
