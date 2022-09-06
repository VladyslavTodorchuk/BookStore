RSpec.describe BookDecorator do
  subject(:decorated_object) { described_class.new(book) }

  let(:book) do
    create(:book, price_cents: 123, authors: authors, categories: categories,
                  categories_count: 0,
                  authors_count: 0)
  end
  let(:authors) do
    [
      create(:author, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name),
      create(:author, first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)
    ]
  end
  let(:categories) do
    [
      create(:category, name: FFaker::Book.genre),
      create(:category, name: FFaker::Book.genre)
    ]
  end

  context 'when decorate' do
    it '#authors_names' do
      expect(book_decorator.authors_names).to eq('Vlad Todorchuk, Stas Todorchuk')
      end
  end
  describe '#categories_names' do
    it { expect(decorated_object.categories_names).to eq("#{categories.first.name}, #{categories.last.name}") }
  end

  describe '#authors_names' do
    it {
      expect(decorated_object.authors_names).to eq("#{authors.first.first_name} #{authors.first.last_name}, " \
                                                      "#{authors.last.first_name} #{authors.last.last_name}")
    }
  end

  describe '#price' do
    it { expect(decorated_object.price).to eq(1.23.to_money) }
  end
end
