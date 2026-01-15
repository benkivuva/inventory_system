module Inventory
  class StockManager
    def initialize(product)
      @product = product
    end

    def increment(amount = 1)
      adjust_stock(amount)
    end

    def decrement(amount = 1)
      adjust_stock(-amount)
    end

    private

    def adjust_stock(amount)
      # 1. Check constraints (soft check)
      if amount.negative? && @product.quantity < amount.abs
        return Result.new(success: false, message: "Insufficient stock for #{@product.name}")
      end

      # 2. Update Product (Model callback handles logging)
      @product.quantity += amount
      
      if @product.save
        action_verb = amount.positive? ? "increased" : "decreased"
        Result.new(success: true, message: "Stock #{action_verb} for #{@product.name}")
      else
        Result.new(success: false, message: @product.errors.full_messages.to_sentence)
      end
    end

    class Result
      attr_reader :message
      def initialize(success:, message:)
        @success = success
        @message = message
      end

      def success?
        @success
      end
    end
  end
end
