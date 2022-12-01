RSpec.describe Delivery do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:delivery) { create(:delivery) }
  let(:delivery_attributes) { attributes_for(:delivery) }

  let(:new_method) { FFaker::Lorem.word }
  let(:old_method) { delivery.delivery_method }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can add delivery' do
    visit 'admin/deliveries'

    click_link('New Delivery')

    fill_in 'delivery[price_cents]', with: delivery_attributes[:price_cents]
    fill_in 'delivery[delivery_method]', with: delivery_attributes[:delivery_method]
    fill_in 'delivery[delivery_day]', with: delivery_attributes[:delivery_day]

    expect { click_button('Create Delivery') }.to change(described_class, :count).from(0).to(1)
  end

  it 'can view delivery' do
    delivery

    visit 'admin/deliveries'

    click_link('View')

    expect(page).to have_content(delivery.delivery_method)
  end

  it 'can edit delivery' do
    delivery

    visit 'admin/deliveries'

    click_link('Edit')

    fill_in 'delivery[delivery_method]', with: new_method

    expect { click_button('Update Delivery') }.to change {
                                                    delivery.reload.delivery_method
                                                  }.from(old_method).to(new_method)
  end

  it 'can delete delivery' do
    delivery

    visit 'admin/deliveries'

    expect { click_link('Delete') }.to change(described_class, :count).from(1).to(0)
  end
end
