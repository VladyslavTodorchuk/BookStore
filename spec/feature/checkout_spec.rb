RSpec.describe 'Checkout', type: :feature, js: true do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:delivery) { create(:delivery) }

  let(:address_attributes) { attributes_for(:address) }
  let(:credit_card_attributes) { attributes_for(:credit_card, user_id: user.id) }

  before do
    sign_in(user)
  end

  describe 'address' do
    it 'update billing' do
      visit checkout_path(step: :address)

      within('div#billing') do
        find_all('div', class: 'form-group')[0] do
          fill_in :first_name, with: address_attributes[:first_name]
        end
        find_all('div', class: 'form-group')[1] do
          fill_in :last_name, with: address_attributes[:last_name]
        end
        find_all('div', class: 'form-group')[2] do
          fill_in :address, with: address_attributes[:address]
        end
        find_all('div', class: 'form-group')[3] do
          fill_in :city, with: address_attributes[:city]
        end
        find_all('div', class: 'form-group')[4] do
          fill_in :zip, with: address_attributes[:zip]
        end
        find_all('div', class: 'form-group')[5] do
          fill_in :country, with: address_attributes[:country]
        end
        find_all('div', class: 'form-group')[6] do
          fill_in :phone, with: address_attributes[:phone]
        end
        click_on I18n.t('settings.save')
      end

      expect(page).to have_content('Billing was updated')
    end

    it 'update shipping' do
      visit checkout_path(step: :address)

      within('div#shipping') do
        find_all('div', class: 'form-group')[0] do
          fill_in :first_name, with: address_attributes[:first_name]
        end
        find_all('div', class: 'form-group')[1] do
          fill_in :last_name, with: address_attributes[:last_name]
        end
        find_all('div', class: 'form-group')[2] do
          fill_in :address, with: address_attributes[:address]
        end
        find_all('div', class: 'form-group')[3] do
          fill_in :city, with: address_attributes[:city]
        end
        find_all('div', class: 'form-group')[4] do
          fill_in :zip, with: address_attributes[:zip]
        end
        find_all('div', class: 'form-group')[5] do
          fill_in :country, with: address_attributes[:country]
        end
        find_all('div', class: 'form-group')[6] do
          fill_in :phone, with: address_attributes[:phone]
        end
        click_on I18n.t('settings.save')
      end

      expect(page).to have_content('Shipping was updated')
    end

    it 'use billing' do
      visit checkout_path(step: :address)

      find('span.checkbox-icon').click

      click_on 'Save and Continue'

      expect(page).to have_content('Billing was picked')
    end

    it 'use shipping' do
      visit checkout_path(step: :address)

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
    before do
      visit checkout_path(step: :payment)
    end

    it 'add credit card' do
      fill_in :credit_card_code, with: credit_card_attributes[:code]
      fill_in :credit_card_name, with: credit_card_attributes[:name]
      fill_in :credit_card_cvv, with: credit_card_attributes[:cvv]
      fill_in :credit_card_expiration_date, with: credit_card_attributes[:expiration_date]

      find('input.btn.btn-default.mb-80').click

      expect(page).to have_content('Credit Card was updated')
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

      find('a.btn.btn-default.mb-20').click

      expect(page).to have_content('Order was created!')
    end
  end
end
