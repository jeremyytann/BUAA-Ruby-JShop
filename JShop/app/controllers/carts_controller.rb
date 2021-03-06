class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]
  before_action :check_for_same?, only: %i[ new create ]

  # GET /carts or /carts.json
  def index
    if user_signed_in?
      if current_user.role == 1
        @owned_carts = Cart.where(user_id: current_user.id)

        @total_price = 0

        @owned_carts.each do |owned_cart|
          @temp_product = Product.find_by(id: owned_cart.product_id)
          @total_price += @temp_product.price.to_d * owned_cart.quantity.to_i
        end
      end
    end
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # quantity += 1
  def inc_one
    @cart = Cart.find(params[:id])
    @cart.update(quantity: @cart.quantity + 1)

    redirect_back(fallback_location: @cart)
  end

  # quantity -= 1
  def dec_one
    @cart = Cart.find(params[:id])
    @cart.update(quantity: @cart.quantity - 1)

    if @cart.quantity == 0
      @cart.destroy
    end

    redirect_back(fallback_location: @cart)
  end

  # POST /carts or /carts.json
  def create
    if @updated
      return
    end

    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        return
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_for_same?
    if Cart.find_by(user_id: params[:user_id], product_id: params[:product_id])
      @old_cart = Cart.find_by(user_id: params[:user_id], product_id: params[:product_id])
      @update_quantity = @old_cart.quantity + params[:quantity].to_i
      @old_cart.update(:quantity => @update_quantity)
      @updated = true
      return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.permit(:user_id, :product_id, :quantity)
    end
end
