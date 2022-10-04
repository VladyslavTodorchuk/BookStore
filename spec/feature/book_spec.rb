RSpec.describe 'Book', type: :feature do
  let(:category_one) { create(:category) }
  let(:category_two) { create(:category) }
  let(:params) do
    { title: FFaker::Book.title,
      description: FFaker::Book.description,
      price_cents: FFaker::Number.rand(1..100),
      dimensions: FFaker::Book.cover,
      year_of_publication: FFaker::Number.rand(1900..2022),
      materials: 'Soft cover',
      quantity: FFaker::Number.rand(2..5) }
  end
  let(:book) { BookDecorator.new(create(:book)) }

  describe '#show book' do
    it 'show books info' do
      visit "books/#{book.id}"

      expect(page).to have_content(book.title)
    end

    it 'clicked Beck to results' do
      visit "books/#{book.id}"

      find('a', class: 'general-back-link').click

      expect(page).to have_content(I18n.t('catalog_page.title'))
    end

    context 'when test read more' do
      it 'show read more' do
        visit "books/#{book.id}"

        expect(page).to have_content(I18n.t('book_page.read_more'))
      end

      it 'clicked read more', js: true do
        visit "books/#{book.id}"

        click_link 'Read More'

        expect(page).not_to have_content(I18n.t('book_page.read_more'))
      end
    end

    context 'when quantity changes', js: true do
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
        within 'ul', class: 'list-inline pt-10 mb-25 mr-240', id: 'filter' do
          click_on category_one.name
        end

        expect(page).to have_content(category_one.books.first.title)
      end
    end

    describe 'filter by all books' do
      before do
        category_one.books.create(params)
        category_two.books.create(params)

        visit books_path

        click_on I18n.t('catalog_page.all')
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
      (BooksController::PAGINATION_PER_PAGE * 2).times do
        books << create(:book)
      end
    end

    let(:books) { [] }

    it 'show books without view more button' do
      visit books_path

      find('a', id: 'view_more', class: 'view_more').click

      expect(page).not_to have_css('a', class: 'view_more hidden', id: 'view_more')
    end

    context 'when view more' do
      it 'show books with view more button' do
        visit books_path

        expect(page).to have_css('a', class: 'view_more')
      end

      it 'show loaded books', js: true do
        visit books_path

        find('a', id: 'view_more', class: 'view_more').click

        expect(page).to have_content(books.last.title)
      end
    end
  end

  describe 'sort' do
    shared_examples 'sort test' do
      it 'sort books' do
        create(:book, title: 'Zimbabwe', price_cents: 75,
                      created_at: 'Thu, 25 Aug 2022 15:20:38.761014000 UTC +00:00')
        create(:book, title: 'Anna', price_cents: 23,
                      created_at: 'Thu, 25 Aug 2022 14:20:38.761014000 UTC +00:00')

        visit books_path

        find('a', class: 'dropdown-toggle lead small', text: I18n.t('catalog_page.sorting.newer_first'),
                  id: 'menu').click

        within 'ul', class: 'dropdown-menu', id: 'sort' do
          click_link button
        end
        expect(find('.col-xs-6.col-sm-3', match: :first)).to have_content(book_title)
      end
    end

    context 'when sort by title A to Z' do
      let(:button) { I18n.t('catalog_page.sorting.title.asc') }
      let(:book_title) { 'Anna' }

      include_examples 'sort test'
    end

    context 'when sort by title Z to A' do
      let(:button) { I18n.t('catalog_page.sorting.title.desc') }
      let(:book_title) { 'Zimbabwe' }

      include_examples 'sort test'
    end

    context 'when sort by price High to Low' do
      let(:button) { I18n.t('catalog_page.sorting.price.desc') }
      let(:book_title) { 'Zimbabwe' }

      include_examples 'sort test'
    end

    context 'when sort by price Low to High' do
      let(:button) { I18n.t('catalog_page.sorting.price.asc') }
      let(:book_title) { 'Anna' }

      include_examples 'sort test'
    end

    context 'when sort by newest' do
      let(:button) { I18n.t('catalog_page.sorting.newer_first') }
      let(:book_title) { 'Zimbabwe' }

      include_examples 'sort test'
    end
  end
end
