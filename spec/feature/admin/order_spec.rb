RSpec.describe Order do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:order) { create(:order) }

  let(:new_status) { 'in delivery' }
  let(:old_status) { order.status }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can view order' do
    order

    visit 'admin/orders'

    find_all('a.view_link.member_link').last.click

    expect(page).to have_content("Order ##{order.id}")
  end

  it 'can edit order' do
    order

    visit 'admin/orders'

    find_all('a.edit_link.member_link').last.click

    find('#order_status').find(:xpath, 'option[5]').select_option

    expect { click_button('Update Order') }.to change { order.reload.status }.from(old_status).to(new_status)
  end

  it 'can delete order' do
    order

    visit 'admin/orders'

    expect { find_all('.delete_link.member_link').last.click }.to change(described_class, :count).from(2).to(1)
  end
end
