class OrdersController < ApplicationController
    # You need to pass item_id as query parameter
    # when using POST /orders
    def create
        item = Item.find_by(id: params[:item_id])

        @order = Order.new
        @order.name = item.name
        @order.description = item.description
        @order.price = item.price
        @order.shop_id = item.shop_id
        @order.item_id = item.id
        @order.user_id = cookies[:user_id]
        @order.save
        redirect_to root_path
    end

    #def update

        #redirect_to "/orders/" + @order.id.to_s
    #end

    def index
        uid = cookies[:user_id]
        @user_type = User.find(uid).user_type
        if @user_type == 0
            @orders = Order.where("user_id = ?", uid)
        else
            @orders = Order.joins("INNER JOIN shops ON orders.shop_id = shops.id AND shops.owner_id = " + uid.to_s)
        end
    end
end
