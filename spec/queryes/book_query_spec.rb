require 'rails_helper'

RSpec.describe BookQuery do
  shared_examples 'sort test' do
    it 'sort' do
      books
      expect(test).to eq(result)
    end
  end

  let(:titles) { %w[Adam Zimbabwe] }
  let(:books_dates) do
    ['Thu, 25 Aug 2022 15:25:38.761014000 UTC +00:00', 'Thu, 25 Aug 2022 14:20:38.761014000 UTC +00:00']
  end

  describe 'all books sort' do
    context 'when sort by title A to Z' do
      let(:books) do
        create(:book, title: titles.first)
        create(:book, title: titles.second)
      end

      let(:result) { titles.second }
      let(:test) { described_class.query({ sort: 'title DESC' }).first.title }

      include_examples 'sort test'
    end

    context 'when sort title Z to A' do
      let(:books) do
        create(:book, title: titles.first)
        create(:book, title: titles.second)
      end

      let(:result) { titles.first }
      let(:test) { described_class.query({ sort: 'title' }).first.title }

      include_examples 'sort test'
    end

    context 'when sort by price High to Low' do
      let(:books) do
        create(:book, price_cents: 75)
        create(:book, price_cents: 23)
      end

      let(:result) { 75 }
      let(:test) { described_class.query({ sort: 'price_cents DESC' }).first.price_cents }

      include_examples 'sort test'
    end

    context 'when sort price Low to High' do
      let(:books) do
        create(:book, price_cents: 75)
        create(:book, price_cents: 23)
      end

      let(:result) { 23 }
      let(:test) { described_class.query({ sort: 'price_cents' }).first.price_cents }

      include_examples 'sort test'
    end

    context 'when sort by Newest' do
      let(:books) do
        create(:book, created_at: books_dates.first)
        create(:book, created_at: books_dates.second)
      end

      let(:result) { books_dates.first }
      let(:test) { described_class.query({ sort: 'created_at DESC' }).first.created_at }

      include_examples 'sort test'
    end
  end
end
