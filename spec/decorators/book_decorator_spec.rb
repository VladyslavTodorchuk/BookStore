require 'rails_helper'

RSpec.describe BookDecorator do
  let(:book_decorator) { described_class.new(book) }
  let(:book) { FactoryBot.create(:book, authors: authors, categories: categories) }

  let(:authors) do
    [
      FactoryBot.create(:author, first_name: 'Vlad', last_name: 'Todorchuk'),
      FactoryBot.create(:author, first_name: 'Stas', last_name: 'Todorchuk')
    ]
  end
  let(:categories) do
    [
      FactoryBot.create(:category, name: 'Poetry'),
      FactoryBot.create(:category, name: 'Novel')
    ]
  end

  context 'when decorate' do
    it '#authors_names' do
      expect(book_decorator.authors_names).to eq('Vlad Todorchuk, Stas Todorchuk')
    end

    it '#categories_names' do
      expect(book_decorator.categories_names).to eq('Poetry, Novel')
    end
  end
end
