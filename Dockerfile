FROM python:3.8-slim-buster

RUN apt-get update \
    && apt-get install -y gcc \
                          python3-dev \
                          libffi-dev \
                          libssl-dev \
                          libxml2-dev \
                          libxslt1-dev \
                          zlib1g-dev \
                          wget \
                          curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt update -y && apt install awscli -y
WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt
RUN pip install --upgrade accelerate
RUN pip uninstall -y transformers accelerate
RUN pip install transformers accelerate

CMD ["python3", "app.py"]
