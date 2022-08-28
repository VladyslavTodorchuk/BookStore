require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid?' do
    context 'when category is valid' do
      it 'is valid' do
        expect(FactoryBot.build(:category)).to be_valid
      end
    end

    context 'when category is invalid' do
      it 'is invalid' do
        expect(FactoryBot.build(:category, name: nil)).not_to be_valid
      end
    end
  end

  describe '#save' do
    context 'when category was saved' do
      it 'saves category' do
        expect(FactoryBot.build(:category).save).to eq(true)
      end
    end

    context 'when category was not saved' do
      it 'saves category' do
        expect(FactoryBot.build(:category, name: nil).save).to eq(false)
      end
    end
  end
end
