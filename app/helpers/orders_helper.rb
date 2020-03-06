module OrdersHelper
    def get_name_by_shop_id(id)
        shop = Shop.find(id)
        return shop.name
    end

    def get_name_by_user_id(id)
        user = User.find(id)
        return user.name
    end
end
