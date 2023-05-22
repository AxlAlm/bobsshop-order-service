FROM python:3.10-slim as base

RUN pip install poetry

COPY ./pyproject.toml ./poetry.lock* ./

RUN poetry export -f requirements.txt --output requirements.txt --without-hashes



FROM public.ecr.aws/lambda/python:3.10 as lambda_base

COPY --from=base requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY ./bobsshop_order_service ./bobsshop_order_service

CMD ["bobsshop_order_service.orders.aws_lambda_handler.get_handler"]
