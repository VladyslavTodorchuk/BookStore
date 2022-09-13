require 'rails_helper'

RSpec.describe BookDecorator do
  subject(:decorated_object) { described_class.new(book) }

  let(:book) do
    FactoryBot.create(:book, price_cents: 123, authors: authors, categories: categories,
                      categories_count: 0,
                      authors_count: 0)
  end
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

  describe '#categories_names' do
    it { expect(decorated_object.categories_names).to eq("#{categories.first.name}, #{categories.last.name}") }
  end

  describe '#authors_names' do
    it {
      expect(decorated_object.authors_names).to eq("#{authors.first.first_name} #{authors.first.last_name}, " \
                                                      "#{authors.last.first_name} #{authors.last.last_name}")
    }
  end


  describe '#price' do
    it { expect(decorated_object.price).to eq(1.23.to_money) }
  end
end

