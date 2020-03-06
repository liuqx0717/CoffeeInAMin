module OrdersHelper
    def get_name_by_shop_id(id)
        shop = Shop.find_by(id: id).take
        return shop.name
    end

    def get_name_by_user_id(id)
        user = User.find_by(id: id).take
        return user.name
    end
end
