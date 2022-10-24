RSpec.describe CreditCard, type: :model do
  context 'when validations' do
    it { is_expected.to allow_values('a' * Constants::CARD_NAME_MAX_LENGTH).for(:name) }
    it { is_expected.to allow_values('4149499809038407', FFaker::Bank.card_number.split(' ').join).for(:code) }
    it { is_expected.to allow_values('342', '123', '423', '093').for(:cvv) }
    it { is_expected.to allow_values('12/42', '01/23', '07/22', '08/99').for(:expiration_date) }
  end

  context 'when not validations' do
    it { is_expected.not_to allow_values('a' * Constants::CARD_NAME_MAX_LENGTH.next).for(:name) }
    it { is_expected.not_to allow_values('3018--dwq12348979-1853').for(:code) }
    it { is_expected.not_to allow_values('1234', 'eqwr').for(:cvv) }
    it { is_expected.not_to allow_values('14/32', '00/217').for(:expiration_date) }
  end

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
  end
end
