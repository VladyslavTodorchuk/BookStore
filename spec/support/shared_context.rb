RSpec.shared_context 'with api request global before and after hooks' do
  before do
    Warden.test_mode!
  end

  after do
    Warden.test_reset!
  end
end

RSpec.shared_context 'with api request authentication helper methods' do
  def sign_in(user, user_type = :user)
    login_as(user, scope: user_type)
  end

  def sign_out
    logout(:user)
  end
end
