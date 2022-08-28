require 'rails_helper'

RSpec.describe Author, type: :model do
  shared_examples 'valid test' do
    it 'valid' do
      expect(author).to be_valid
    end
  end

  shared_examples 'invalid test' do
    it 'invalid' do
      expect(author).not_to be_valid
    end
  end

  shared_examples 'save test' do
    it 'save' do
      expect(author.save).to eq(result)
    end
  end

  shared_examples 'destroy test' do
    before do
      author.destroy
    end

    it 'destroyed?' do
      expect(author.destroyed?).to eq(result)
    end
  end

  describe '#valid' do
    context 'when first_name and last_name is valid' do
      let(:author) { FactoryBot.build(:author) }

      include_examples 'valid test'
    end
  end

  describe '#invalid' do
    context 'when first_name is not passed' do
      let(:author) { FactoryBot.build(:author, first_name: nil) }

      include_examples 'invalid test'
    end

    context 'when last_name is not passed' do
      let(:author) { FactoryBot.build(:author, last_name: nil) }

      include_examples 'invalid test'
    end
  end

  describe 'save' do
    context 'when valid author save' do
      let(:author) { FactoryBot.build(:author) }
      let(:result) { true }

      include_examples 'save test'
    end

    context 'when invalid author dont save' do
      let(:author) { FactoryBot.build(:author, last_name: nil) }
      let(:result) { false }

      include_examples 'save test'
    end
  end

  describe 'add books' do
    let(:author) { FactoryBot.create(:author) }
    let(:book) { FactoryBot.create(:book) }

    it 'added book to author' do
      FactoryBot.create(:authors_book, book_id: book.id, author_id: author.id)
      expect(author.books.size).to eq(1)
    end
  end

  describe 'destroy' do
    context 'when author was destroyed' do
      let(:author) { FactoryBot.create(:author) }
      let(:result) { true }

      include_examples 'destroy test'
    end
  end
end
