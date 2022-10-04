class UserCheckoutService
  def self.checkout(params)
    if params.count.eql? 2
      User.find_by(params)
    else
      User.create(email: params[:email], password: SecureRandom.hex)

    end
  end
end
