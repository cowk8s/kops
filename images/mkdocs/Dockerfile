FROM alpine:3.16

RUN apk add --no-cache \
  bash \
  python3 \
  python3-dev \
  build-base \
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --upgrade pip setuptools

COPY requirements.txt /requirements.txt
RUN pip install -U -r /requirements.txt

WORKDIR /docs

EXPOSE 3000

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
