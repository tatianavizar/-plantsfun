class OrdersController < ApplicationController
  def index

  end

  def new
    @order = Order.new
    @orderable = Orderable.all
  end
end
