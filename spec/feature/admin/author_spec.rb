RSpec.describe Author do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  let(:new_name) { FFaker::Name.first_name }
  let(:old_name) { author.first_name }

  let(:author) { create(:author) }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can create an author' do
    visit 'admin/authors'

    click_link('New Author')

    fill_in 'author[first_name]', with: first_name
    fill_in 'author[last_name]', with: last_name

    expect { click_button('Create Author') }.to change(described_class, :count).from(0).to(1)
  end

  it 'can delete an author' do
    author

    visit 'admin/authors'

    expect { click_link('Delete') }.to change(described_class, :count).from(1).to(0)
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

    fill_in 'author[first_name]', with: new_name

    expect { click_button('Update Author') }.to change { author.reload.first_name }.from(old_name).to(new_name)
  end
end
