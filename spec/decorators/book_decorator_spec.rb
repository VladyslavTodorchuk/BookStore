require 'rails_helper'

RSpec.describe BookDecorator do
  subject(:decorated_object) { described_class.new(book) }

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
    it '#categories_names' do
      expect(decorated_object.categories_names).to eq("#{categories.first.name}, #{categories.last.name}")
    end
  end

  describe '#authors_names' do
    it do
      expect(decorated_object.authors_names).to eq("#{authors.first.first_name} #{authors.first.last_name}, #{authors.last.first_name} #{authors.last.last_name}")
    end
  end
end
