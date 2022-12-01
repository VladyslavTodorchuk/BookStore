RSpec.describe BestSellersQuery do
  shared_examples 'bestsellers' do
    it 'query' do
      order_books1
      order_books2
      order

      expect(test).to eq(result)
    end
  end

  let(:book1) { create(:book, quantity: 2) }
  let(:book2) { create(:book, quantity: 5) }

  let(:order) { create(:order, status: 'created') }

  let(:order_books1) { create(:order_book, order: order, book: book1, quantity: book1.quantity.pred) }
  let(:order_books2) { create(:order_book, order: order, book: book2, quantity: book2.quantity.pred) }

  describe '#query' do
    context 'when bestsellers' do
      let(:test) { described_class.query.first.title }
      let(:result) { book2.title }

      include_examples 'bestsellers'
    end
  end
end
