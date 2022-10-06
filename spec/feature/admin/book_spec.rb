RSpec.describe 'Book' do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:book) { create(:book) }
  let(:params) { attributes_for(:book) }

  let(:old_title) { book.title }
  let(:new_title) { FFaker::Book.title }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can create an book' do
    visit 'admin/books'

    click_link('New Book')

    fill_in 'book[title]', with: params[:title]
    fill_in 'book[description]', with: params[:description]
    fill_in 'book[year_of_publication]', with: params[:year_of_publication]
    fill_in 'book[price_cents]', with: params[:price_cents]
    fill_in 'book[materials]', with: params[:materials]
    fill_in 'book[dimensions]', with: params[:dimensions]
    fill_in 'book[quantity]', with: params[:quantity]

    expect { click_button('Create Book') }.to change(Book, :count).from(0).to(1)
  end

  it 'can delete an book' do
    book
    visit 'admin/books'

    expect { click_link('Delete') }.to change(Book, :count).from(1).to(0)
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
end
