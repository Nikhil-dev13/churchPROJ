FROM python:alpine

RUN apk update \
    && apk add libpq postgresql-dev \
    && apk add build-base

RUN mkdir -p /app

WORKDIR /app

COPY requirements.txt /tmp/requirements.txt

RUN set -ex && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    rm -rf /root/.cache/

COPY . /app/

EXPOSE 8000

CMD ["gunicorn", "church.wsgi", "-b", "0.0.0.0:8000", "--access-logfile", "-"]
