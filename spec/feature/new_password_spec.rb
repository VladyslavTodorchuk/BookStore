require_relative '../rails_helper'
require_relative '../support/shared_context'

RSpec.describe 'New Password', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  describe '#new_password' do
    it 'change password' do
      user.reset_password('newPassword', 'newPassword')

      expect(user.password).to eq('newPassword')
    end

    it 'not validate password' do
      visit new_user_password_path

      fill_in 'email', with: user.email

      click_on I18n.t('login.send_instructions')

      expect(page).to have_content(I18n.t('devise.passwords.send_instructions'))
    end
  end
end
