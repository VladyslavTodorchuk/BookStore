RSpec.describe 'Checkout', type: :feature, js: true do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { create(:user) }
  let(:shipping) { create(:address, user: user) }
  let(:credit_card) { create(:credit_card, user: user) }

  let(:delivery) { create(:delivery) }
  let(:order) { create(:order, user: user, address: shipping, delivery: delivery) }
  let(:order_book) { create(:order_book, order: order, book: create(:book)) }

  let(:address_attributes) { attributes_for(:address) }
  let(:credit_card_attributes) { attributes_for(:credit_card) }

  before do
    credit_card
    order
    order_book

    sign_in(user)
  end

  describe 'address' do
    before do
      visit checkout_path(step: :address)
    end

    it 'didn\'t update billing' do
      within('div#billing') do
        fill_in :billing_last_name, with: address_attributes[:last_name]
        fill_in :billing_address, with: address_attributes[:address]
        fill_in :billing_city, with: address_attributes[:city]
        fill_in :billing_zip, with: address_attributes[:zip]
        fill_in :billing_country, with: address_attributes[:country]
        fill_in :billing_phone, with: address_attributes[:phone]

        click_on I18n.t('settings.save')
      end

      expect(page).to have_content('All Fields Should Be Required')
    end

    it 'update billing' do
      within('div#billing') do
        fill_in :billing_first_name, with: address_attributes[:first_name]
        fill_in :billing_last_name, with: address_attributes[:last_name]
        fill_in :billing_address, with: address_attributes[:address]
        fill_in :billing_city, with: address_attributes[:city]
        fill_in :billing_zip, with: address_attributes[:zip]
        fill_in :billing_country, with: address_attributes[:country]
        fill_in :billing_phone, with: address_attributes[:phone]

        click_on I18n.t('settings.save')
      end

      expect(page).to have_content('Billing was updated')
    end

    it 'didn\'t update shipping' do
      within('div#shipping') do
        fill_in :shipping_first_name, with: address_attributes[:first_name]
        fill_in :shipping_address, with: address_attributes[:address]
        fill_in :shipping_city, with: address_attributes[:city]
        fill_in :shipping_zip, with: address_attributes[:zip]
        fill_in :shipping_country, with: address_attributes[:country]
        fill_in :shipping_phone, with: address_attributes[:phone]

        click_on I18n.t('settings.save')
      end

      expect(page).to have_content('All Fields Should Be Required')
    end

    it 'update shipping' do
      within('div#shipping') do
        fill_in :shipping_first_name, with: address_attributes[:first_name]
        fill_in :shipping_last_name, with: address_attributes[:last_name]
        fill_in :shipping_address, with: address_attributes[:address]
        fill_in :shipping_city, with: address_attributes[:city]
        fill_in :shipping_zip, with: address_attributes[:zip]
        fill_in :shipping_country, with: address_attributes[:country]
        fill_in :shipping_phone, with: address_attributes[:phone]

        click_on I18n.t('settings.save')
      end

      expect(page).to have_content('Shipping was updated')
    end

    it 'use billing' do
      find('span.checkbox-icon').click

      click_on 'Save and Continue'

      expect(page).to have_content('Billing was picked')
    end

    it 'use shipping' do
      click_on 'Save and Continue'

      expect(page).to have_content('Shipping was picked')
    end
  end

  describe 'delivery' do
    before do
      delivery

      visit checkout_path(step: :delivery)
    end

    it 'pick delivery' do
      find_all('label.radio-label').last.click

      click_on 'Save and Continue'

      expect(page).to have_content('Method was picked')
    end
  end

  describe 'credit_card' do
    it 'add credit card' do
      visit checkout_path(step: :payment)

      fill_in :credit_card_code, with: credit_card_attributes[:code]
      fill_in :credit_card_name, with: credit_card_attributes[:name]
      fill_in :credit_card_cvv, with: credit_card_attributes[:cvv]
      fill_in :credit_card_expiration_date, with: credit_card_attributes[:expiration_date]

      find('input.btn.btn-default.mb-80').click

      expect(page).to have_content('Credit Card was updated')
    end

    it 'show hint' do
      visit checkout_path(step: :payment)

      find('i.fa.fa-question-circle.general-form-help.cvv_info').click

      expect(page).to have_content(I18n.t('orders.messages.cvv_message'))
    end
  end

  describe 'confirm' do
    it 'confirm order' do
      visit checkout_path(step: :confirm)

      find('a.btn.btn-default.mb-20').click

      expect(page).to have_content('Thank You for your Order!')
    end
  end

  describe 'complete' do
    it 'complete order' do
      visit checkout_path(step: :complete)

      find('input.btn.btn-default.mb-20').click

      expect(page).to have_content('Order was created!')
    end
  end
end
