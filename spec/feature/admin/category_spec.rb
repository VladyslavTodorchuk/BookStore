RSpec.describe 'Category' do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:category) { create(:category) }

  let(:new_name) { FFaker::Book.genre }
  let(:old_name) { category.name }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can create an category' do
    visit 'admin/categories'

    click_link('New Category')

    fill_in 'category[name]', with: new_name

    expect { click_button('Create Category') }.to change(Category, :count).from(0).to(1)
  end

  it 'can delete an category' do
    category

    visit 'admin/categories'

    expect { click_link('Delete') }.to change(Category, :count).from(1).to(0)
  end

  it 'can view an category' do
    category

    visit 'admin/categories'

    click_link('View')

    expect(page).to have_content(category.name)
  end

  it 'can edit an category' do
    category

    visit 'admin/categories'

    click_link('Edit')

    fill_in 'category[name]', with: new_name

    expect { click_button('Update Category') }.to change { category.reload.name }.from(old_name).to(new_name)
  end
end
