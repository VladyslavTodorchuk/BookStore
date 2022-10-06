RSpec.describe 'Admin_Category' do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:category_name) { FFaker::Book.genre }

  let(:category) { create(:category) }

  before do
    sign_in(create(:admin_user))

    category

    visit 'admin/categories'
  end

  it 'can create an category' do
    click_link('New Category')

    fill_in 'category[name]', with: category_name

    click_button('Create Category')

    expect(page).to have_content(category_name)
  end

  it 'can delete an category' do
    click_link('Delete')

    expect(page).not_to have_content(category.name)
  end

  it 'can view an category' do
    click_link('View')

    expect(page).to have_content(category.name)
  end

  it 'can edit an category' do
    click_link('Edit')

    fill_in 'category[name]', with: 'New Genre'

    click_button('Update Category')

    expect(page).to have_content('New Genre')
  end
end
