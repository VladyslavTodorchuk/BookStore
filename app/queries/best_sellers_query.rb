class BestSellersQuery
  def self.query
    Book.find_by_sql(sql_query)
  end

  def self.sql_query
    %[SELECT b.*, SUM(ob.quantity) as total_quantity
      FROM order_books ob JOIN orders o ON ob.order_id = o.id JOIN books b ON ob.book_id = b.id
      WHERE o.status in ('created', 'delivered', 'confirmed')
      GROUP BY b.id
      ORDER BY total_quantity DESC LIMIT #{Constants::BESTSELLERS_LIMIT};]
  end
end
