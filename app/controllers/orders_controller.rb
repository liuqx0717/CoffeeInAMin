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

    def show
        redirect_to root_path
    end

    def checkout_new
        @order = Order.find params[:id]
    end

    def checkout
        @order = Order.find params[:id]
        raise "Please, check registration errors" unless @order.valid?
        process_payment
        # @order.status = 'COMPLETED'
        @order.save
        redirect_to @order, notice: 'Order was successfully created.'
    end

    private
    def stripe_params
        params.permit :stripeEmail, :stripeToken
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_order
        @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
        params.require(:order).permit(:full_name, :telephone)
    end

    def index
        uid = cookies[:user_id]
        @user_type = User.find(uid).user_type
        if @user_type == 0
            @orders = Order.where("user_id = ?", uid)
        else
            @orders = Order.joins("INNER JOIN shops ON orders.shop_id = shops.id AND shops.owner_id = " + uid.to_s)
        end
    end

    def process_payment
        Stripe.api_key = "sk_test_7sWbbjSHC46cm4udZL48y75D00Pvpg8zE5"
        customer = Stripe::Customer.create email: stripe_params["stripeEmail"],
                                           card: stripe_params["stripeToken"]

        Stripe::Charge.create customer: customer.id,
                              amount: @order.price.to_i * 100,
                              description: @order.description,
                              currency: 'usd'

    end
end
