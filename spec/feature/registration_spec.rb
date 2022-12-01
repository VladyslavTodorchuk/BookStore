RSpec.describe 'Registration', type: :feature do
  let(:user) { create(:user, email: FFaker::Internet.email) }

  describe '#sing_up' do
    before do
      visit new_user_registration_path
    end

    context 'when successfully sing_up' do
      it 'sing_up users' do
        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: FFaker::Internet.email
          fill_in 'user_password', with: user.password
          fill_in 'user_password_confirmation', with: user.password

          click_on I18n.t('header.sing_up')
        end

        expect(page).to have_text I18n.t('devise.registrations.signed_up_but_unconfirmed')
      end
    end

    context 'when users is already exits' do
      it 'sing_up users' do
        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          fill_in 'user_password_confirmation', with: user.password

          click_on I18n.t('header.sing_up')
        end

        expect(page).to have_text('Email has already been taken')
      end
    end

    context 'when unsuccessfully sing_up' do
      it 'didn`t sing_up' do
        within 'form', class: 'new_user', id: 'new_user' do
          fill_in 'user_email', with: FFaker::Internet.email
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'wrong'

          click_on I18n.t('header.sing_up')
        end

        expect(page).to have_text '1 error prohibited this user from being saved'
      end
    end
  end
end
