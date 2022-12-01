RSpec.describe 'Orders', type: :feature, js: true do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:book) { create(:book) }
  let(:order_books) { create(:order_book, order_id: order.id, book_id: book.id) }

  describe '#loggedin user' do
    it 'on click checkout render address page' do
      sign_in(user)
      order
      order_books

      visit root_path

      find('a.shop-link.pull-right.hidden-xs').click
      find('a#checkout_button.btn.btn-default.hidden-xs').click

      expect(page).to have_content('Checkout')
    end
  end

  describe '#guest' do
    before do
      book

      visit book_path(book.id)

      click_button I18n.t('book_page.add_to_card')

      find('a.shop-link.pull-right.hidden-xs').click
      find('input.btn.btn-default.mb-20.hidden-xs.center-block').click
    end

    context 'when has an account' do
      it 'continue using account' do
        within('form#login') do
          fill_in :user_email, with: user.email
          fill_in :user_password, with: user.password

          click_on I18n.t('checkout.log_in_with_password')
        end

        expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      end
    end

    context 'when dont have an account' do
      it 'fast registration' do
        within('form#fast_reg') do
          fill_in :user_email, with: 'test@rspec.com'
          click_on I18n.t('checkout.continue')
        end

        expect(page).to have_content('Checkout')
      end

      it 'email is already taken' do
        within('form#fast_reg') do
          fill_in :user_email, with: user.email
          click_on I18n.t('checkout.continue')
        end

        expect(page).to have_content(I18n.t('checkout.error_message'))
      end
    end
  end

  describe '#index' do
    shared_examples 'sort test' do
      it 'sort orders' do
        sign_in(user)

        create(:order, user: user, status: result_status)
        create(:order, user: user, status: 'created')

        visit orders_path

        find('a.dropdown-toggle.lead.small').click

        within('ul.dropdown-menu') do
          click_link sort
        end

        expect(page).to have_content(result_status.capitalize)
      end
    end

    context 'when sort by created status' do
      let(:sort) { I18n.t('orders.sorting.status.created') }
      let(:result_status) { 'created' }

      include_examples 'sort test'
    end

    context 'when sort by confirmed status' do
      let(:sort) { I18n.t('orders.sorting.status.confirm') }
      let(:result_status) { 'confirmed' }

      include_examples 'sort test'
    end

    context 'when sort by in delivery status' do
      let(:sort) { I18n.t('orders.sorting.status.in_delivery') }
      let(:result_status) { 'in delivery' }

      include_examples 'sort test'
    end

    context 'when sort by delivered status' do
      let(:sort) { I18n.t('orders.sorting.status.delivered') }
      let(:result_status) { 'delivered' }

      include_examples 'sort test'
    end

    context 'when sort by canceled status' do
      let(:sort) { I18n.t('orders.sorting.status.canceled') }
      let(:result_status) { 'canceled' }

      include_examples 'sort test'
    end
  end
end
