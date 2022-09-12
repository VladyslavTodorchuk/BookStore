require_relative '../rails_helper'
require_relative '../support/shared_context'

RSpec.describe 'Settings', type: :feature do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in(user)

    visit edit_user_path(user.id)
  end

  describe '#email_change' do
    it 'change email' do
      within('div', id: 'email') do
        fill_in :email, with: FFaker::Internet.email

        click_on I18n.t('settings.save')
      end

      user.confirm

      expect(page).to have_content(I18n.t('settings.message.update'))
    end
  end

  describe '#password_change' do
    context 'when error' do
      it 'didnt change password' do
        within('div', id: 'password') do
          fill_in :current_password, with: user.password
          fill_in :password, with: 'newPassword'
          fill_in :password_confirmation, with: 'incorrectPassword'

          click_on I18n.t('settings.save')
        end

        user.confirm

        expect(page).to have_content(I18n.t('settings.error.error'))
      end
    end

    context 'when successful' do
      it 'didnt change password' do
        within('div', id: 'password') do
          fill_in :current_password, with: user.password
          fill_in :password, with: 'newPassword'
          fill_in :password_confirmation, with: 'newPassword'

          click_on I18n.t('settings.save')
        end

        user.confirm

        expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
      end
    end
  end
end
