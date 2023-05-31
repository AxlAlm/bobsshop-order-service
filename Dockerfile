FROM python:3.10-slim as base

# RUN pip install --upgrade pip 
RUN pip install poetry poetry==1.4.2
 
COPY ./pyproject.toml ./poetry.lock* ./

RUN poetry export -f requirements.txt --output requirements.txt --without-hashes


FROM public.ecr.aws/lambda/python:3.10

COPY --from=base requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY ./bobsshop_order_service ./bobsshop_order_service

CMD ["bobsshop_order_service.orders.aws_lambda_handler.create_handler"]
