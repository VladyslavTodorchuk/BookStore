RSpec.describe 'Admin_Author' do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  let(:author) { create(:author) }

  before do
    sign_in(create(:admin_user))
  end

  it 'can create an author' do
    visit 'admin/authors'

    click_link('New Author')

    fill_in 'author[first_name]', with: first_name
    fill_in 'author[last_name]', with: last_name

    click_button('Create Author')

    expect(page).to have_content(first_name)
  end

  it 'can delete an author' do
    author

    visit 'admin/authors'

    click_link('Delete')

    expect(page).not_to have_content(author.first_name)
  end

  it 'can view an author' do
    author

    visit 'admin/authors'

    click_link('View')

    expect(page).to have_content(author.first_name)
  end

  it 'can edit an author' do
    author

    visit 'admin/authors'

    click_link('Edit')

    fill_in 'author[first_name]', with: 'Vlad'

    click_button('Update Author')

    expect(page).to have_content('Vlad')
  end
end
