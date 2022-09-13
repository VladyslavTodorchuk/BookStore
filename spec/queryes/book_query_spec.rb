require 'rails_helper'

RSpec.describe BookQuery do
  shared_examples 'sort test' do
    it 'sort' do
      books
      expect(test).to eq(result)
    end
  end

  describe 'all books sort' do
    context 'when sort by title A to Z' do
      let(:books) do
        FactoryBot.create(:book, title: 'Adam')
        FactoryBot.create(:book, title: 'Zimbabwe')
      end

      let(:result) { 'Zimbabwe' }
      let(:test) { described_class.query({ sort: 'title DESC' }).first.title }

      include_examples 'sort test'
    end

    context 'when sort title Z to A' do
      let(:books) do
        FactoryBot.create(:book, title: 'Adam')
        FactoryBot.create(:book, title: 'Zimbabwe')
      end

      let(:result) { 'Adam' }
      let(:test) { described_class.query({ sort: 'title' }).first.title }

      include_examples 'sort test'
    end

    context 'when sort by price High to Low' do
      let(:books) do
        FactoryBot.create(:book, price: 75)
        FactoryBot.create(:book, price: 23)
      end

      let(:result) { 75 }
      let(:test) { described_class.query({ sort: 'price DESC' }).first.price }

      include_examples 'sort test'
    end

    context 'when sort price Low to High' do
      let(:books) do
        FactoryBot.create(:book, price: 75)
        FactoryBot.create(:book, price: 23)
      end

      let(:result) { 23 }
      let(:test) { described_class.query({ sort: 'price' }).first.price }

      include_examples 'sort test'
    end

    context 'when sort by Newest' do
      let(:books) do
        FactoryBot.create(:book, created_at: 'Thu, 25 Aug 2022 14:20:38.761014000 UTC +00:00')
        FactoryBot.create(:book, created_at: 'Thu, 25 Aug 2022 15:25:38.761014000 UTC +00:00')
      end

      let(:result) { 'Thu, 25 Aug 2022 15:25:38.761014000 UTC +00:00' }
      let(:test) { described_class.query({ sort: 'created_at DESC' }).first.created_at }

      include_examples 'sort test'
    end
  end
end
