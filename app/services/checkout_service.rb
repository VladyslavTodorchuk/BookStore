class CheckoutService
  def self.to_errors(message)
    message.map do |k, v|
      "#{k} #{v.join(', ')}"
    end.join("\n")
  end
end
