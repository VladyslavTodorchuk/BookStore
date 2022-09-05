require 'rails_helper'

RSpec.describe 'Homes', type: :feature do
  describe 'Get Started' do
    it 'on click move to catalog page' do
      visit root_path

      click_on 'Get Started'

      expect(page).to have_content('Catalog')
    end
  end

  describe 'navbar' do
    let(:books_category) { FactoryBot.create(:books_category) }

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
  end
end
