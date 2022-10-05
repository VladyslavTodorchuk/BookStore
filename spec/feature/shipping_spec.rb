RSpec.describe 'Shipping', type: :feature do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { FactoryBot.create(:user) }
  let(:attributes_for) { attributes_for(:shipping) }

  describe '#fill_in' do
    it 'fill in shipping' do
      sign_in(user)

      visit edit_user_path(user.id)

      within('div', id: 'shipping') do
        find_all('div', class: 'form-group')[0] do
          fill_in :first_name, with: attributes_for[:first_name]
        end
        find_all('div', class: 'form-group')[1] do
          fill_in :last_name, with: attributes_for[:last_name]
        end
        find_all('div', class: 'form-group')[2] do
          fill_in :address, with: attributes_for[:address]
        end
        find_all('div', class: 'form-group')[3] do
          fill_in :city, with: attributes_for[:city]
        end
        find_all('div', class: 'form-group')[4] do
          fill_in :zip, with: attributes_for[:zip]
        end
        find_all('div', class: 'form-group')[5] do
          fill_in :country, with: attributes_for[:country]
        end
        find_all('div', class: 'form-group')[6] do
          fill_in :phone, with: attributes_for[:phone]
        end
        click_on I18n.t('settings.save')
      end

      expect(page).to have_content(I18n.t('settings.message.update'))
    end
  end
end
