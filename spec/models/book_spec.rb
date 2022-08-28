require 'rails_helper'

RSpec.describe Book, type: :model do
  shared_examples 'valid test' do
    it 'valid' do
      expect(my_book).to be_valid
    end
  end

  shared_examples 'invalid test' do
    it 'invalid' do
      expect(my_book).not_to be_valid
    end
  end

  shared_examples 'destroy' do
    before do
      my_book.destroy
    end

    it 'destroyed?' do
      expect(my_book.destroyed?).to eq(result)
    end
  end

  shared_examples 'save' do
    it 'saved?' do
      expect(my_book.save).to eq(result)
    end
  end

  describe 'book valid' do
    context 'when book valid' do
      let(:my_book) do
        FactoryBot.build(:book, title: FFaker::Book.title, description: FFaker::Book.description,
                                price: FFaker::Number.rand(100),
                                year_of_publication: FFaker::Number.rand(1900..2022),
                                materials: 'Soft', dimensions: '12:32:12')
      end

      include_examples 'valid test'
    end
  end

  describe 'book invalid' do
    context 'when book invalid without title' do
      let(:my_book) do
        FactoryBot.build(:book, title: nil, description: FFaker::Book.description,
                                price: FFaker::Number.rand(100),
                                year_of_publication: FFaker::Number.rand(1900..2022),
                                materials: 'Soft', dimensions: '12:32:12')
      end

      include_examples 'invalid test'
    end

    context 'when book invalid without description' do
      let(:my_book) do
        FactoryBot.build(:book, title: FFaker::Book.title, description: nil,
                                price: FFaker::Number.rand(100),
                                year_of_publication: FFaker::Number.rand(1900..2022),
                                materials: 'Soft', dimensions: '12:32:12')
      end

      include_examples 'invalid test'
    end

    context 'when book invalid without price' do
      let(:my_book) do
        FactoryBot.build(:book, title: FFaker::Book.title, description: FFaker::Book.description,
                                price: nil,
                                year_of_publication: FFaker::Number.rand(1900..2022),
                                materials: 'Soft', dimensions: '12:32:12')
      end

      include_examples 'invalid test'
    end
  end

  describe 'book save' do
    context 'when book been saved' do
      let(:my_book) do
        FactoryBot.build(:book)
      end
      let(:result) { true }

      include_examples 'save'
    end

    context 'when book not been saved' do
      let(:my_book) do
        FactoryBot.build(:book, price: nil)
      end
      let(:result) { false }

      include_examples 'save'
    end
  end

  describe 'book destroy' do
    context 'when book been destroyed' do
      let(:my_book) do
        FactoryBot.build(:book)
      end
      let(:result) { true }

      include_examples 'destroy'
    end
  end
end
