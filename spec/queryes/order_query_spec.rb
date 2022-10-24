RSpec.describe OrderQuery do
  shared_examples 'sort test' do
    it 'sort' do
      order1
      order2

      expect(test).to eq(result)
    end
  end

  let(:user) { create(:user) }

  describe 'all order' do
    context 'all' do
      let(:order1) { create(:order, user: user, status: 'created') }
      let(:order2) { create(:order, user: user, status: 'created') }

      let(:result) { order1.id }
      let(:test) { described_class.query({ }, user).first.id }

      include_examples 'sort test'
    end

    context 'sort by price HIGH to LOW' do
      let(:order1) { create(:order, user: user, status: 'created', total_price: 1234) }
      let(:order2) { create(:order, user: user, status: 'created', total_price: 1000) }

      let(:result) { order1.id }
      let(:test) { described_class.query({ sort: 'total_price DESC' }, user).first.id }

      include_examples 'sort test'
    end

    context 'sort by price LOW to HIGH' do
      let(:order1) { create(:order, user: user, status: 'created', total_price: 1234) }
      let(:order2) { create(:order, user: user, status: 'created', total_price: 1000) }

      let(:result) { order2.id }
      let(:test) { described_class.query({ sort: 'total_price' }, user).first.id }

      include_examples 'sort test'
    end
  end

  describe 'sort by status' do
    context 'status' do
      let(:order1) { create(:order, user: user, status: 'created') }
      let(:order2) { create(:order, user: user, status: 'delivered') }

      let(:result) { order2.id }
      let(:test) { described_class.query({ status: 'delivered' }, user).first.id }

      include_examples 'sort test'
    end

    context 'sort by price HIGH to LOW' do
      let(:order1) { create(:order, user: user, status: 'delivered', total_price: 1234) }
      let(:order2) { create(:order, user: user, status: 'delivered', total_price: 1000) }

      let(:result) { order1.id }
      let(:test) { described_class.query({ status: 'delivered', sort: 'total_price DESC' }, user).first.id }

      include_examples 'sort test'
    end

    context 'sort by price LOW to HIGH' do
      let(:order1) { create(:order, user: user, status: 'delivered', total_price: 1234) }
      let(:order2) { create(:order, user: user, status: 'delivered', total_price: 1000) }

      let(:result) { order2.id }
      let(:test) { described_class.query({ status: 'delivered', sort: 'total_price' }, user).first.id }

      include_examples 'sort test'
    end
  end
end
