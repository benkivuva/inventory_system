module Inventory
  class StockManager
    def initialize(product)
      @product = product
    end

    def increment(amount = 1)
      @product.quantity += amount
      save_with_result("Stock increased for #{@product.name}")
    end

    def decrement(amount = 1)
      if @product.quantity < amount
        return Result.new(success: false, message: "Insufficient stock for #{@product.name}")
      end

      @product.quantity -= amount
      save_with_result("Stock decreased for #{@product.name}")
    end

    private

    def save_with_result(success_message)
      if @product.save
        Result.new(success: true, message: success_message)
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
