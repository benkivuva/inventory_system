class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy adjust_stock ]

  # GET /products
  require 'csv'

  def index
    @products = Product.with_attached_image.all.order(created_at: :desc)
    
    if params[:query].present?
      @products = @products.where("name LIKE ?", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.turbo_stream
      format.csv do
        send_data generate_csv(@products), filename: "products-#{Date.today}.csv"
      end
    end
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Product was successfully destroyed.' }
      format.turbo_stream
    end
  end

  # PATCH /products/1/adjust_stock
  def adjust_stock
    manager = Inventory::StockManager.new(@product)
    
    @result = if params[:adjustment] == "increment"
      manager.increment
    else
      manager.decrement
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: @result.message }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def generate_csv(products)
    CSV.generate(headers: true) do |csv|
      csv << ["ID", "Name", "Description", "Price", "Quantity", "Low Stock Threshold"]
      products.each do |product|
        csv << [product.id, product.name, product.description, product.price, product.quantity, product.low_stock_threshold]
      end
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :low_stock_threshold, :image)
  end
end
