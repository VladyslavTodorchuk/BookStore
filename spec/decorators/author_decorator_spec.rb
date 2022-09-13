require_relative '../rails_helper'

RSpec.describe AuthorDecorator, type: :decorator do
  subject(:decorated_object) { described_class.new(author) }

  let(:author) { FactoryBot.create(:author) }

  describe '#full_name' do
    it { expect(decorated_object.full_name).to eq("#{author.first_name} #{author.last_name}") }
  end
end
