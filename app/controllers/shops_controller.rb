class ShopsController < ApplicationController
    def new
        @shop = Shop.new
    end

    def index
        @shops = Shop.all
    end

    def create
        @shop = Shop.new
        @shop.name = params[:name]
        @shop.address = params[:address]
        @shop.description = params[:description]
        @shop.save
        redirect_to root_path
    end

    def show
        @shop = Shop.find params[:id]
    end

    def update
        @shop = Shop.find params[:id]
        @shop.name = params[:name]
        @shop.address = params[:address]
        @shop.description = params[:description]
        @shop.save

        redirect_to "/shops/" + @shop.id.to_s
    end

    def menu
        @menu = Item.find_by shop_id: params[:id]
    end
end
