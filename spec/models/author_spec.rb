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
      expect(described_class.new(params).save).to eq(result)
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
      let(:author) { described_class.new(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }

      include_examples 'valid test'
    end
  end

  describe '#invalid' do
    context 'when first_name is not passed' do
      let(:author) { described_class.new(first_name: FFaker::Name.first_name) }

      include_examples 'invalid test'
    end

    context 'when last_name is not passed' do
      let(:author) { described_class.new(last_name: FFaker::Name.last_name) }

      include_examples 'invalid test'
    end
  end

  describe 'save' do
    context 'when valid author save' do
      let(:params) { { first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name } }
      let(:result) { true }

      include_examples 'save test'
    end

    context 'when invalid author dont save' do
      let(:params) { { first_name: FFaker::Name.first_name } }
      let(:result) { false }

      include_examples 'save test'
    end
  end

  describe 'add books' do
    let(:author) { described_class.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }
    let(:book_params) do
      { title: FFaker::Book.title,
        description: FFaker::Book.description,
        price: FFaker::Number.rand(100) }
    end

    it 'added book to author' do
      author.books.create(book_params)
      expect(author.books.first.title).to eq(book_params[:title])
    end
  end

  describe 'destroy' do
    context 'when author was destroyed' do
      let(:author) { described_class.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }
      let(:result) { true }

      include_examples 'destroy test'
    end

    context 'when author was destroyed and book also' do
      let(:author) { described_class.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }
      let(:book_params) do
        { title: FFaker::Book.title,
          description: FFaker::Book.description,
          price: FFaker::Number.rand(100) }
      end

      it 'check that book was added' do
        author.books.create(book_params)
        expect(author.books.empty?).to eq(false)
      end

      it 'destroy author' do
        author.destroy
        expect(author.destroyed?).to eq(true)
      end

      it 'destroy book' do
        expect(author.books.empty?).to eq(true)
      end
    end
  end
end
