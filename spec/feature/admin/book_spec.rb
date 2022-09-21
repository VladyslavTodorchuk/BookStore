RSpec.describe Book do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:book) { create(:book) }
  let(:book_attributes) { attributes_for(:book) }
  let(:old_title) { book.title }
  let(:new_title) { FFaker::Book.title }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can create an book' do
    click_link('New Book')

    fill_in 'book[title]', with: book_attributes[:title]
    fill_in 'book[description]', with: book_attributes[:description]
    fill_in 'book[year_of_publication]', with: book_attributes[:year_of_publication]
    fill_in 'book[price_cents]', with: book_attributes[:price_cents]
    fill_in 'book[materials]', with: book_attributes[:materials]
    fill_in 'book[dimensions]', with: book_attributes[:dimensions]
    fill_in 'book[quantity]', with: book_attributes[:quantity]

    expect { click_button('Create Book') }.to change(described_class, :count).from(0).to(1)
  end

  it 'can delete an book' do
    book
    visit 'admin/books'

    expect { click_link('Delete') }.to change(described_class, :count).from(1).to(0)
  end

  it 'can view an book' do
    book
    visit 'admin/books'

    click_link('View')

    expect(page).to have_content(book.title)
  end

  it 'can edit an book' do
    book
    visit 'admin/books'

    click_link('Edit')

    fill_in 'book[title]', with: new_title

    expect { click_button('Update Book') }.to change { book.reload.title }.from(old_title).to(new_title)
  end

  context 'when image' do
    before do
      book
      visit 'admin/books'

      click_link('Edit')

      page.attach_file('book[images][]', './app/assets/images/Web-Book-Cover.png')

      click_on 'Update Book'
    end

    it 'can add images to book' do
      expect(book.reload.images.count).to eq(1)
    end

    it 'can delete images from book' do
      click_link('Edit')

      click_link('Delete')

      expect(book.reload.images.count).to eq(0)
    end
  end
end
