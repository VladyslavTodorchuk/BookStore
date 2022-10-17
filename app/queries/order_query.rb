class OrderQuery
  SORT_METHODS = ['created_at', 'created_at DESC', 'total_price DESC', 'total_price',
                  'status', 'status DESC'].freeze
  ORDER_STATUS = %w[delivered confirmed created canceled].freeze

  def self.query(params, current_user)
    if SORT_METHODS.include?(params[:sort].to_s)
      if params[:status].nil?
        Order.where(user_id: current_user.id, status: %i[delivered created confirmed canceled]).order(params[:sort])
      else
        Order.where(user_id: current_user.id, status: params[:status]).order(params[:sort])
      end
    elsif ORDER_STATUS.include?(params[:status].to_s)
      Order.where(user_id: current_user.id, status: params[:status])
    else
      Order.where(user_id: current_user.id, status: %i[delivered created confirmed canceled])
    end
  end
end
