RSpec.describe Order do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:order) { create(:order) }
  let(:order_attributes) { attributes_for(:order) }

  let(:new_status) { FFaker::Lorem.word }
  let(:old_status) { order.status }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can view order' do
    order

    visit 'admin/orders'

    click_link('View')

    expect(page).to have_content(order.id)
  end

  it 'can edit order' do
    order

    visit 'admin/orders'

    click_link('Edit')

    fill_in 'order[status]', with: new_method

    expect { click_button('Update Order') }.to change { order.reload.status }.from(old_status).to(new_status)
  end

  it 'can delete order' do
    order

    visit 'admin/orders'

    expect { click_link('Delete') }.to change(described_class, :count).from(1).to(0)
  end
end
