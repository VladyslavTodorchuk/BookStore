require 'rails_helper'

RSpec.describe AuthorDecorator do
  let(:decorator) { described_class.new(author) }

  let(:author) { FactoryBot.create(:author, first_name: 'Vlad', last_name: 'Todorchuk') }

  context 'when decorate' do
    it '#full_name' do
      expect(decorator.full_name).to eq('Vlad Todorchuk')
    end
  end
end
