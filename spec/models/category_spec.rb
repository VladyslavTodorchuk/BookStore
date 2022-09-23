require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'category' do
    context 'when validations' do
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'when associations' do
      it { is_expected.to have_many(:books_categories).dependent(:destroy) }
      it { is_expected.to have_many(:books).through(:books_categories) }
    end
  end
end
