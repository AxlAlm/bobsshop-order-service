from bobsshop_order_service.orders.schemas import Order, OrderCreate

orders = {
    1: Order(id=1, user_id=1, item_ids=[1, 2, 3]),
}


def get(id: int) -> Order:
    return orders[id]


def create(order: OrderCreate) -> Order:
    id = len(orders) + 1
    created_order = Order.parse_obj(**{"id": id} | order.dict())
    orders[id] = created_order
    return created_order
