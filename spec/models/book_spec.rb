require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'books' do
    context 'validations' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:price) }
      it { should validate_presence_of(:year_of_publication) }
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:materials) }
      it { should validate_presence_of(:dimensions) }
    end
  end
end
