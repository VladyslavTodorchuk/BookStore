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
      materials: 'Soft cover',
      quantity: FFaker::Number.rand(2..5) }
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
        expect(page).to have_content("€#{book.price * 2}")
      end

      it 'decrease quantity' do
        find('a', class: 'dec').click
        expect(page).to have_content("€#{book.price}")
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

  describe 'sort' do
    shared_examples 'sort test' do
      it 'sort books' do
        FactoryBot.create(:book, title: 'Zimbabwe', price: 75,
                                 created_at: 'Thu, 25 Aug 2022 15:20:38.761014000 UTC +00:00')
        FactoryBot.create(:book, title: 'Anna', price: 23, created_at: 'Thu, 25 Aug 2022 14:20:38.761014000 UTC +00:00')

        visit books_path

        find('a', class: 'dropdown-toggle', text: 'Newest first').click

        within '.dropdown-menu' do
          click_link button
        end
        expect(find('.col-xs-6.col-sm-3', match: :first)).to have_content(book_title)
      end
    end

    context 'when sort by title A to Z' do
      let(:button) { 'Title: A to Z' }
      let(:book_title) { 'Anna' }

      include_examples 'sort test'
    end

    context 'when sort by title Z to A' do
      let(:button) { 'Title: Z to A' }
      let(:book_title) { 'Zimbabwe' }

      include_examples 'sort test'
    end

    context 'when sort by price High to Low' do
      let(:button) { 'Price: High to Low' }
      let(:book_title) { 'Zimbabwe' }

      include_examples 'sort test'
    end

    context 'when sort by price Low to High' do
      let(:button) { 'Price: Low to High' }
      let(:book_title) { 'Anna' }

      include_examples 'sort test'
    end

    context 'when sort by newest' do
      let(:button) { 'Newest first' }
      let(:book_title) { 'Zimbabwe' }

      include_examples 'sort test'
    end
  end
end
