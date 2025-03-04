class OrdersController < ApplicationController
    require 'rubygems'
    require 'rqrcode'
    # You need to pass item_id as query parameter
    # when using POST /orders

    def index
        uid = cookies.signed[:user_id]
        if uid == nil
            render "/login_issues"
            return
        end
        @user_type = User.find(uid).user_type
        if @user_type == 0
            @orders = Order.where("user_id = ? and (status = ? or status = ? or status = ?)", uid, "NEW", "COMPLETED", "FINISHED")
            @last_order = @orders.order("created_at").last
            qrcode = RQRCode::QRCode.new("order_id:" + @last_order.id.to_s)
            @png = qrcode.as_png.resize(250, 250).to_data_url
        else
            @orders = Order.joins("INNER JOIN shops ON orders.shop_id = shops.id AND shops.owner_id = " + uid.to_s)
        end
    end


    def create
        if cookies.signed[:user_id] == nil
            render "/login_issues"
            return
        end
        item = Item.find_by(id: params[:item_id])

        @order = Order.new
        @order.name = item.name
        @order.description = item.description
        @order.price = item.price
        @order.shop_id = item.shop_id
        @order.item_id = item.id
        @order.user_id = cookies.signed[:user_id]
        @order.status = "NEW"
        @order.save
        redirect_to "/orders/"+ @order.id.to_s + "/checkout"
    end

    def show
        redirect_to root_path
    end

    def checkout_new
        @order = Order.find params[:id]
    end

    def qrcode
        render "qrcode"
    end

    def process_qrcode
        @order_found = Order.find_by_id params[:order_id]
        @temp = params[:order_id]
        if @order_found.nil?
            @qr_info = "Cannot find this order"
        elsif @order_found.status == "NEW"
            @qr_info = "This order hasn't been checkout"
        elsif @order_found.status == "FINISHED"
            @qr_info = "This order has been picked up"
        else
            @qr_info = "Success"
            @order_found.status = "FINISHED"
            @order_found.save()
        end
    end

    def checkout
        @order = Order.find params[:id]
        raise "Please, check registration errors" unless @order.valid?
        process_payment
        @order.status = 'COMPLETED'
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


    def process_payment
        Stripe.api_key = Rails.application.credentials.stripe_secret_key
        customer = Stripe::Customer.create email: stripe_params["stripeEmail"],
                                           card: stripe_params["stripeToken"]

        Stripe::Charge.create customer: customer.id,
                              amount: @order.price.to_i * 100,
                              description: @order.description,
                              currency: 'usd'

    end
end
