class CartController < ApplicationController
  include ActionView::RecordIdentifier

  def show
    @render_cart = false
  end

  def add
    @plant = Plant.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(plant_id: @plant.id)
    if current_orderable && quantity > 0
      current_orderable.update(quantity: quantity + 1)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(plant: @plant, quantity: quantity)
    end
    redirect_to root_path, notice: "The plant was added to your cart"
  end

  def remove
    Rails.logger.debug "Params received in remove: #{params.inspect}"

    orderable = Orderable.find_by(id: params[:id])

    if orderable
      orderable.destroy
      Rails.logger.debug "Orderable destroyed: #{orderable.inspect}"

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart })
        end
        format.html { redirect_to cart_path, notice: "Item removed successfully." }
      end
    else
      Rails.logger.debug "Orderable not found with id: #{params[:id]}"

      respond_to do |format|
        format.html { redirect_to cart_path, alert: "Item not found." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart })
        end
      end
    end
  end

  def increment_quantity
    orderable = Orderable.find_by(id: params[:id], cart_id: @cart.id)

    if orderable
      orderable.increment!(:quantity)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(orderable), partial: 'cart/orderable', locals: { orderable: orderable }) }
        format.html { redirect_to cart_path, notice: "Quantity increased." }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_path, alert: "Item not found." }
      end
    end
  end

  def decrement_quantity
    orderable = Orderable.find_by(id: params[:id], cart_id: @cart.id)

    if orderable && orderable.quantity > 1
      orderable.decrement!(:quantity)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(orderable), partial: 'cart/orderable', locals: { orderable: orderable }) }
        format.html { redirect_to cart_path, notice: "Quantity decreased." }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_path, alert: "Cannot decrease quantity below 1." }
      end
    end
  end

  def order
    @cart.id
  end
end
