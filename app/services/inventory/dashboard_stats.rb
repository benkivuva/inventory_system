module Inventory
  class DashboardStats
    def total_inventory_value
      Product.sum("price * quantity")
    end

    def items_at_risk
      Product.low_stock.count
    end

    def out_of_stock_count
      Product.where(quantity: 0).count
    end
  end
end
