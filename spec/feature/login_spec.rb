require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  let(:user_second) { FactoryBot.create(:user, email: 'test.rspec@rspec.ua') }

  describe '#login' do
    before do
      user_second.confirm
      visit new_user_session_path
    end

    context 'when successfully login' do
      it 'login' do
        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: user_second.email
          fill_in 'user_password', with: user_second.password

          click_on I18n.t('header.log_in')
        end

        expect(page).to have_text I18n.t('devise.sessions.signed_in')
      end
    end

    context 'when unsuccessfully login' do
      it 'didn`t login' do
        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: user_second.email
          fill_in 'user_password', with: 'wrong_password'

          click_on I18n.t('header.log_in')
        end

        expect(page).to have_text 'Invalid Email or password.'
      end
    end
  end
end
