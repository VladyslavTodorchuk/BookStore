RSpec.describe 'Coupon', type: :feature, js: true do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { FactoryBot.create(:user) }
  let(:coupon) { FactoryBot.create(:coupon, discount: 0.15) }
  let(:order) { FactoryBot.create(:order, user_id: user.id, books_count: 0) }
  let(:book) { FactoryBot.create(:book, price_cents: 1234) }
  let(:order_book) { FactoryBot.create(:order_book, order_id: order.id, book_id: book.id) }

  before do
    sign_in(user)
    order
    order_book
    visit order_path(order.id)
  end

  describe '#valid coupon' do
    before do
      fill_in 'input', with: coupon.code

      click_button I18n.t('order.apply')
    end

    it 'sub price' do
      expect(page).to have_content("SubTotal:\n€ 12.34")
    end

    it 'use coupon' do
      expect(page).to have_content("Coupon:\n€ 1.85")
    end

    it 'count price with coupon' do
      expect(page).to have_content('Order Total: € 10.49')
    end
  end

  describe '#invalid coupon' do
    it 'show error message' do
      fill_in 'input', with: 'dasdasdqe1243wasad'

      click_button I18n.t('order.apply')

      expect(page).to have_content(I18n.t('order.coupon.error'))
    end
  end
end
