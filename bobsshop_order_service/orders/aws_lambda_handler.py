from bobsshop_order_service.orders.schemas import OrderCreate
from bobsshop_order_service.orders.services import create, get


def get_handler(event, context):
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
        API Gateway Lambda Proxy Input Format

        Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    API Gateway Lambda Proxy Output Format: dict

        Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html
    """

    return {"statusCode": 200, "body": get(id=1).json()}


def create_handler(event, context):
    print(event)
    print(type(event))
    order_create = OrderCreate.parse_obj(**event)
    return {"statusCode": 201, "body": create(order_create).json()}


# def get_handler(event, context):
#     return {
#         "statusCode": 200,
#         "body": json.dumps(
#             {
#                 "message": "hello world",
#                 # "location": ip.text.replace("\n", "")
#             }
#         ),
#     }


# def get_handler(event, context):


#     # try:
#     #     ip = requests.get("http://checkip.amazonaws.com/")
#     # except requests.RequestException as e:
#     #     # Send some context about this error to Lambda Logs
#     #     print(e)

#     #     raise e

#     return {
#         "statusCode": 200,
#         "body": json.dumps(
#             {
#                 "message": "hello world",
#                 # "location": ip.text.replace("\n", "")
#             }
#         ),
#     }
