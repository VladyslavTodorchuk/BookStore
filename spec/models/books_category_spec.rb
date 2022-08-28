require 'rails_helper'

RSpec.describe BooksCategory, type: :model do
  let(:book) { FactoryBot.create(:book) }
  let(:category) { FactoryBot.create(:category) }
  let(:books_category) { FactoryBot.create(:books_category, category_id: category.id, book_id: book.id) }

  describe '#add category to book' do
    context 'when add one Author to book' do
      it 'check if book dont have categories' do
        expect(book.categories.size).to eq(0)
      end

      it 'add category for book' do
        books_category
        expect(book.categories.size).to eq(1)
      end
    end
  end

  describe '#destroy category for book' do
    context 'when destroy (relationship)' do
      it 'destroy category for book' do
        books_category.destroy
        expect(books_category.destroyed?).to eq(true)
      end
    end
  end
end
