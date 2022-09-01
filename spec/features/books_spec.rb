require 'rails_helper'

RSpec.describe 'Books', type: :feature do
  let(:category_one) { FactoryBot.create(:category) }
  let(:category_two) { FactoryBot.create(:category) }
  let(:params) do
    { title: FFaker::Book.title,
      description: FFaker::Book.description,
      price: FFaker::Number.rand(1..100),
      dimensions: FFaker::Book.cover,
      year_of_publication: FFaker::Number.rand(1900..2022),
      materials: 'Soft cover' }
  end
  let(:book) { FactoryBot.create(:book) }

  describe '#show book' do
    it 'show books info' do
      visit "books/#{book.id}"

      expect(page).to have_content(book.title)
    end

    it 'clicked Beck to results' do
      visit "books/#{book.id}"

      find('a', class: 'general-back-link').click

      expect(page).to have_content('Catalog')
    end

    context 'when test read more' do
      it 'show read more' do
        visit "books/#{book.id}"

        expect(page).to have_content('Read More')
      end

      it 'clicked read more' do
        visit "books/#{book.id}"

        click_link 'Read More'

        expect(page).not_to have_content('Read More')
      end
    end

    context 'when quantity changes' do
      before do
        visit "books/#{book.id}"

        find('a', class: 'inc').click
      end

      it 'increase quantity' do
        expect(page).to have_content("€ #{book.price * 2}")
      end

      it 'decrease quantity' do
        find('a', class: 'dec').click
        expect(page).to have_content("€ #{book.price}")
      end
    end
  end

  describe '#catalog' do
    describe 'filter by category' do
      before do
        category_one.books.create(params)
        visit books_path
      end

      after do
        category_one.destroy
      end

      it 'show book count for category' do
        expect(page).to have_content(category_one.books.size)
      end

      it 'filter book by category' do
        click_on category_one.name

        expect(page).to have_content(category_one.books.first.title)
      end
    end

    describe 'filter by all books' do
      before do
        category_one.books.create(params)
        category_two.books.create(params)

        visit books_path

        click_on 'All'
      end

      after do
        category_one.destroy
        category_two.destroy
      end

      it 'shown books for first category' do
        expect(page).to have_content(category_one.books.first.title)
      end

      it 'shown books for second category' do
        expect(page).to have_content(category_two.books.first.title)
      end
    end
  end

  describe 'load_more' do
    before do
      (ApplicationHelper::PAGINATION_PER_PAGE * 2).times do
        books << FactoryBot.create(:book)
      end
    end

    let(:books) { [] }

    it 'show books without view more button' do
      visit books_path

      find('a', class: 'view-more').click
      expect(page).not_to have_css('a', class: 'view-more')
    end

    context 'when view more' do
      it 'show books with view more button' do
        visit books_path

        expect(page).to have_css('a', class: 'view-more')
      end

      it 'show loaded books' do
        visit books_path

        find('a', class: 'view-more').click
        expect(page).to have_content(books.last.title)
      end
    end
  end
end
