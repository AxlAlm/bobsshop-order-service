from pydantic import BaseModel


class Order(BaseModel):
    id: int
    user_id: int
    item_ids: list[int]


class OrderCreate(BaseModel):
    user_id: int
    item_ids: list[int]
