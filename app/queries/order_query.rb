class OrderQuery
  SORT_METHODS = ['created_at', 'created_at DESC', 'total_price DESC', 'total_price',
                  'status', 'status DESC'].freeze
  ORDER_STATUS = ['delivered', 'confirmed', 'created', 'canceled', 'in delivery'].freeze

  def self.query(params, current_user)
    if SORT_METHODS.include?(params[:sort])
      if params[:status].nil?
        Order.where(user_id: current_user.id, status: ORDER_STATUS).order(params[:sort])
      else
        Order.where(user_id: current_user.id, status: params[:status]).order(params[:sort])
      end
    elsif ORDER_STATUS.include?(params[:status])
      Order.where(user_id: current_user.id, status: params[:status])
    else
      Order.where(user_id: current_user.id, status: ORDER_STATUS)
    end
  end
end
