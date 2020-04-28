require 'open-uri'
class ShopsController < ApplicationController
    def new
        
    end

    def index
        @shops = Shop.all
        ip = request.ip
        ip = "74.71.4.205" if ip == "127.0.0.1" || ip == "::1"
        result = Geocoder.search(ip)
        lat_lng = GoogleDistanceMatrix::Place.new lng: result.first.coordinates[1], lat: result.first.coordinates[0]
        @routes = {}
        for shop in @shops
            matrix = GoogleDistanceMatrix::Matrix.new
            matrix.origins << lat_lng
            dest_address = GoogleDistanceMatrix::Place.new lng: shop.longitude, lat: shop.latitude
            matrix.destinations << dest_address
            route_from_map = matrix.shortest_route_by_distance_to(dest_address)
            route = CustomRoutes.new((route_from_map.distance_in_meters / 1609.344).round(2), (route_from_map.duration_in_seconds / 60).round(2))
            @routes[shop] = route
        end
        @shops.sort do |shop|
            @routes[shop].distance
        end
    end

    def create
        @shop = Shop.new
        @shop.name = params[:name]
        @shop.address = params[:address]
        @shop.description = params[:description]
        @shop.time = params[:time]
        @shop.owner_id = params[:owner_id]
        @shop.pic.attach(params[:pic]) unless params[:pic] == nil
        @shop.save
        redirect_to root_path
    end

    def show
        @results = Geocoder.search(request.ip)
        @shop = Shop.find params[:id]
        @is_owner = cookies.signed[:user_id].to_s == @shop.owner_id.to_s
    end

    def update
        @shop = Shop.find params[:id]
        @shop.name = params[:name]
        @shop.address = params[:address]
        @shop.description = params[:description]
        @shop.time = params[:time]
        unless params[:pic] == nil
            @shop.pic.purge if @shop.pic.attached?
            @shop.pic.attach(params[:pic])
        end
        @shop.save
        redirect_to "/shops/" + @shop.id.to_s
    end

    def menu
        @is_owner = Shop.find(params[:id]).owner_id.to_s == cookies.signed[:user_id].to_s
        @menu = Item.where("shop_id = ?", params[:id])
    end

    class CustomRoutes
        attr_reader :distance, :duration
        def initialize(distance, duration)
            @distance = distance
            @duration = duration
        end
    end
end
