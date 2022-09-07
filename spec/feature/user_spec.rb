require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { FactoryBot.build(:user, email: 'test.rspec@rspec.ua') }
  let(:user_second) { FactoryBot.create(:user, email: 'test.rspec-test@rspec.ua') }

  describe '#sing_up' do
    context 'when successfully sing_up' do
      before do
        visit new_user_registration_path

        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          fill_in 'user_password_confirmation', with: user.password

          click_on I18n.t('header.sing_up')
        end
      end

      it 'sing_up user' do
        expect(page).to have_text I18n.t('devise.registrations.signed_up_but_unconfirmed')
      end
    end

    context 'when unsuccessfully sing_up' do
      it 'didn`t sing_up' do
        visit new_user_registration_path

        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: FFaker::Internet.email
          fill_in 'user_password', with: 'wrong'
          fill_in 'user_password_confirmation', with: 'wrong'

          click_on I18n.t('header.sing_up')
        end

        expect(page).to have_text '1 error prohibited this user from being saved'
      end
    end
  end

  describe '#login' do
    before do
      user_second.confirm
    end

    context 'when successfully login' do
      it 'login' do
        visit new_user_session_path

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
        visit new_user_session_path

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
