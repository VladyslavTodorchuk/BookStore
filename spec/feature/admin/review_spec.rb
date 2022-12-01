RSpec.describe 'Review' do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:review) { create(:review, verified: false) }

  before do
    sign_in(create(:admin_user), :admin_user)
  end

  it 'can delete an review' do
    review

    visit 'admin/reviews'

    expect { click_link('Delete') }.to change(Review, :count).from(1).to(0)
  end

  it 'can view an review' do
    review

    visit 'admin/reviews'

    click_link('View')

    expect(page).to have_content(review.title)
  end

  it 'can edit an review' do
    review

    visit 'admin/reviews'
    click_link('Edit')

    find('input#review_verified').click

    expect { click_button('Update Review') }.to change { review.reload.verified }.from(false).to(true)
  end
end
