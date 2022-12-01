RSpec.describe 'Cart', type: :feature, js: true do
  let(:book) { FactoryBot.create(:book) }

  before do
    book
    visit book_path(book.id)

    click_button I18n.t('book_page.add_to_card')
  end

  describe '#add_book_to_order' do
    it 'add book to order' do
      find_all('span#books_count.shop-quantity')[0] do
        expect(page).to have_content(1)
      end
    end
  end

  describe '#quantity_change' do
    it 'book quantity inc' do
      visit orders_path

      within("a#inc#{book.id}.input-link") do
        find('i.fa.fa-plus.line-heaght-40').click
      end

      sleep(2)

      expect(find_field("counter#{book.id}").value).to eq('2')
    end

    it 'book quantity dec' do
      visit orders_path

      within("a#dec#{book.id}.input-link") do
        find('i.fa.fa-minus.line-heaght-40').click
      end

      sleep(2)

      expect(find_field("counter#{book.id}").value).to eq('0')
    end
  end

  describe '#remove_book_from_cart' do
    it 'remove book from cart' do
      visit orders_path

      find('button.close.general-cart-close').click

      expect(page).to have_content(I18n.t('order.messages.delete'))
    end
  end
end
