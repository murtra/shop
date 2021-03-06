class OrdersController < ApplicationController  
  before_action :authenticate_user!  
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :load_products, only: [:new, :edit, :create, :update] 

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new  
    @order.line_items.build
  end

  # GET /orders/1/edit
  def edit 
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        OrderMailer.order_created(@order, current_user).deliver
        format.html { redirect_to @order, notice: t('generic.successfully_created') }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: t('generic.successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:status, :payment_mode, :address, :city, :name, :last_name, line_items_attributes: [:id, :quantity, :price, :product_id, :_destroy])
    end 
    
    # Load products list
    def load_products
      @products = Product.all
    end 
    
end
