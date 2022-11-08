RSpec.describe 'Review', type: :feature do
  include_context 'with api request authentication helper methods'
  include_context 'with api request global before and after hooks'

  let(:user) { create(:user).decorate }
  let(:book) { create(:book).decorate }

  before do
    sign_in(user)

    visit book_path(book)
  end

  shared_examples 'review' do
    it 'review' do
      find('i', id: rating).click

      fill_in :title, with: FFaker::Lorem.sentence(title_words)
      fill_in :body, with: FFaker::Lorem.sentence(body_words)

      click_on I18n.t('reviews.post')

      expect(page).to have_content(result)
    end
  end

  describe '#post review', js: true do
    context 'when review posted' do
      let(:rating) { "star#{rand(1..5)}" }
      let(:title_words) { 3 }
      let(:body_words) { 4 }
      let(:result) { I18n.t('reviews.success') }

      include_examples 'review'
    end

    context 'when review not been posted' do
      let(:rating) { "star#{rand(1..5)}" }
      let(:title_words) { 20 }
      let(:body_words) { 30 }
      let(:result) { 'Title is too long (maximum is 80 characters)' }

      include_examples 'review'
    end
  end
end
