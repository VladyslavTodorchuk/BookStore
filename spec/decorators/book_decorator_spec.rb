require 'rails_helper'

RSpec.describe BookDecorator do
  subject(:decorated_object) { described_class.new(book) }

  let(:book) { FactoryBot.create(:book, authors: authors, categories: categories) }
  let(:authors) do
    [
      FactoryBot.create(:author, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name),
      FactoryBot.create(:author, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)
    ]
  end
  let(:categories) do
    [
      FactoryBot.create(:category, name: FFaker::Book.genre),
      FactoryBot.create(:category, name: FFaker::Book.genre)
    ]
  end

  context 'when decorate' do
    it '#categories_names' do
      expect(decorated_object.categories_names).to eq("#{categories.first.name}, #{categories.last.name}")
    end

    it '#authors_names' do
      expect(decorated_object.authors_names).to eq("#{authors.first.first_name} #{authors.first.last_name}, " \
                                                     "#{authors.last.first_name} #{authors.last.last_name}")
    end
  end
end
