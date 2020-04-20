class ItemsController < ApplicationController
    # You need to provide shop_id as a query string 
    # when using GET /items/new
    def new
        
    end

    def create
        @item = Item.new
        @item.name = params[:name]
        @item.description = params[:description]
        @item.price = params[:price]
        @item.shop_id = params[:shop_id]
        @item.pic.attach(params[:pic])
        @item.save
        redirect_to root_path
    end

    def show
        @item = Item.find params[:id]
        @shop = Shop.find @item.shop_id
        @is_owner = false
        @user_type = 0
        unless cookies.signed[:user_id] == nil
            @is_owner = @shop.owner_id.to_s == cookies.signed[:user_id].to_s
            user = User.find cookies.signed[:user_id]
            @user_type = user.user_type
        end
    end

    def update
        @item = Item.find params[:id]
        @item.name = params[:name]
        @item.description = params[:description]
        @item.price = params[:price]
        unless params[:pic] == nil
            @item.pic.purge if @item.pic.attached?
            @item.pic.attach(params[:pic])
        end
        #@item.shop_id = params[:shop_id]
        @item.save

        redirect_to "/items/" + @item.id.to_s
    end
end
