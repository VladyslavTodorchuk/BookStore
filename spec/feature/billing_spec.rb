RSpec.describe 'Billing', type: :feature do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { create(:user) }

  describe '#fill_in' do
    it 'fill in billing' do
      sign_in(user)

      visit edit_user_path(user.id)

      within('div', id: 'billing') do
        find_all('div', class: 'form-group')[0] do
          fill_in :first_name, with: FFaker::Name.first_name
        end
        find_all('div', class: 'form-group')[1] do
          fill_in :last_name, with: FFaker::Name.last_name
        end
        find_all('div', class: 'form-group')[2] do
          fill_in :address, with: FFaker::AddressUA.street_address
        end
        find_all('div', class: 'form-group')[3] do
          fill_in :city, with: FFaker::AddressUA.city
        end
        find_all('div', class: 'form-group')[4] do
          fill_in :zip, with: FFaker::AddressUA.zip_code
        end
        find_all('div', class: 'form-group')[5] do
          fill_in :country, with: FFaker::AddressUA.country
        end
        find_all('div', class: 'form-group')[6] do
          fill_in :phone, with: FFaker::PhoneNumberUA.phone_number
        end
        click_on I18n.t('settings.save')
      end

      expect(page).to have_content(I18n.t('settings.message.update'))
    end
  end
end
