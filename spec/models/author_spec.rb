require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'author' do
    context 'validations' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
    end

    context 'associations' do
      it { should have_many(:authors_books).dependent(:destroy) }
      it { should have_many(:books).through(:authors_books) }
    end
  end
end
