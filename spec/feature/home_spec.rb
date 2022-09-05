<<<<<<< HEAD
=======
require 'rails_helper'
<<<<<<< HEAD
require_relative '../support/shared_context'

>>>>>>> 4e81ea2 (Featire specs)
RSpec.describe 'Home', type: :feature do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  describe 'Get Started' do
    it 'on click move to catalog page' do
      visit root_path

      click_on 'Get Started'

      expect(page).to have_content('Catalog')
    end
  end

  describe 'navbar' do
    let(:books_category) { create(:books_category) }

    it 'on click home move to root-path' do
      visit books_path

      find('a', id: 'root').click

      expect(page).to have_content('Get Started')
    end

    it 'on click category name move to root-path with books that belong to this category' do
      books_category

      visit root_path

      find('a', class: 'dropdown-toggle', text: 'Shop').click

      within('ul', id: 'nav') do
        find('a', class: 'collapse-link', text: books_category.category.name).click
      end

      expect(page).to have_content(books_category.category.books.first.title)
    end

    context 'when guest' do
      it 'on click login go to login page' do
        visit root_path

        within 'div', class: 'visible-xs' do
          click_link I18n.t('header.log_in')
        end

        expect(page).to have_content(I18n.t('header.log_in'))
      end

      it 'on click sing up go to sing up page' do
        visit root_path

        within 'div', class: 'visible-xs' do
          click_link I18n.t('header.sing_up')
        end

        expect(page).to have_content(I18n.t('header.sing_up'))
      end
    end

    context 'when user', js: true do
      let(:user) { create(:user) }

      before do
        sign_in(user)
      end

      it 'on click account show settings' do
        visit root_path

        click_on I18n.t('header.account')

        expect(page).to have_content(I18n.t('header.settings'))
      end

      it 'on click account show log_out' do
        visit root_path

        click_on I18n.t('header.account')

        expect(page).to have_content(I18n.t('header.log_out'))
      end

      it 'log_out' do
        visit root_path

        click_on I18n.t('header.account')

        click_on(I18n.t('header.log_out'), match: :first)

        expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
      end
    end
  end
end
