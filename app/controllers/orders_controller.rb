class OrdersController < ApplicationController
    def create
        @order = Order.new
        @order.name = params[:name]
        @order.description = params[:description]
        @order.price = params[:price]
        @order.shop_id = params[:shop_id]
        @order.item_id = params[:item_id]
        @order.user_id = cookies[:user_id]
        @order.save
        redirect_to root_path
    end

    #def update

        #redirect_to "/orders/" + @order.id.to_s
    #end

    def index
        @orders = Order.find_by user_id: cookies[:user_id]
    end
end
