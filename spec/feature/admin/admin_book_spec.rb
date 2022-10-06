RSpec.describe 'Admin_Book' do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:book) { create(:book) }
  let(:params) do
    { title: FFaker::Book.title,
      description: FFaker::Book.description,
      price_cents: FFaker::Number.rand(1..100),
      dimensions: FFaker::Book.cover,
      year_of_publication: FFaker::Number.rand(1900..2022),
      materials: 'Soft cover',
      quantity: FFaker::Number.rand(2..5) }
  end

  before do
    sign_in(create(:admin_user))

    book

    visit 'admin/books'
  end

  it 'can create an category' do
    click_link('New Book')

    fill_in 'book[title]', with: params[:title]
    fill_in 'book[description]', with: params[:description]
    fill_in 'book[year_of_publication]', with: params[:year_of_publication]
    fill_in 'book[price_cents]', with: params[:price_cents]
    fill_in 'book[materials]', with: params[:materials]
    fill_in 'book[dimensions]', with: params[:dimensions]
    fill_in 'book[quantity]', with: params[:quantity]

    click_button('Create Book')

    expect(page).to have_content(params[:title])
  end

  it 'can delete an book' do
    click_link('Delete')

    expect(page).not_to have_content(book.title)
  end

  it 'can view an book' do
    click_link('View')

    expect(page).to have_content(book.title)
  end

  it 'can edit an book' do
    click_link('Edit')

    fill_in 'book[title]', with: 'New title'

    click_button('Update Book')

    expect(page).to have_content('New title')
  end
end
