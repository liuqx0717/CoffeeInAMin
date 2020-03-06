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
        @item.save
        redirect_to root_path
    end

    def show
        @item = Item.find params[:id]
    end

    def update
        @item = Item.find params[:id]
        @item.name = params[:name]
        @item.description = params[:description]
        @item.price = params[:price]
        #@item.shop_id = params[:shop_id]
        @item.save

        redirect_to "/items/" + @item.id.to_s
    end
end
