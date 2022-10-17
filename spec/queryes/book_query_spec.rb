RSpec.describe BookQuery do
  shared_examples 'sort test' do
    it 'sort' do
      book1
      book2

      expect(test).to eq(result)
    end
  end

  let(:title1) { 'Adam' }
  let(:title2) { 'Zimbabwe' }

  let(:date1) { 'Thu, 25 Aug 2022 15:25:38.761014000 UTC +00:00' }
  let(:date2) { 'Thu, 25 Aug 2022 14:20:38.761014000 UTC +00:00' }

  describe 'all books sort' do
    context 'when sort by title A to Z' do
      let(:book1) { create(:book, title: title1) }
      let(:book2) { create(:book, title: title2) }

      let(:result) { title2 }
      let(:test) { described_class.query({ sort: 'title DESC' }).first.title }

      include_examples 'sort test'
    end

    context 'when sort title Z to A' do
      let(:book1) { create(:book, title: title1) }
      let(:book2) { create(:book, title: title2) }

      let(:result) { title1 }
      let(:test) { described_class.query({ sort: 'title' }).first.title }

      include_examples 'sort test'
    end

    context 'when sort by price High to Low' do
      let(:book1) { create(:book, price_cents: 75) }
      let(:book2) { create(:book, price_cents: 23) }

      let(:result) { 75 }
      let(:test) { described_class.query({ sort: 'price_cents DESC' }).first.price_cents }

      include_examples 'sort test'
    end

    context 'when sort price Low to High' do
      let(:book1) { create(:book, price_cents: 75) }
      let(:book2) { create(:book, price_cents: 23) }

      let(:result) { 23 }
      let(:test) { described_class.query({ sort: 'price_cents' }).first.price_cents }

      include_examples 'sort test'
    end

    context 'when sort by Newest' do
      let(:book1) { create(:book, created_at: date1) }

      let(:book2) { create(:book, created_at: date2) }

      let(:result) { date1 }
      let(:test) { described_class.query({ sort: 'created_at DESC' }).first.created_at }

      include_examples 'sort test'
    end
  end
end
