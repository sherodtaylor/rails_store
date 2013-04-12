module ProductsHelper
  def total
    total = Product.select("price").where(:in_cart => true)
    total.sum(:price)
    # total.to_a.inject{|sum, n| sum + n}
  end
  def in_cart_items
     Product.where(:in_cart => true)
  end
end
