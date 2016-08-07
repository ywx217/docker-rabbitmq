FROM ywx217/docker-webmanage-base:latest
MAINTAINER Wenxuan Yang "ywx217@gmail.com"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r rabbitmq && useradd -r -g rabbitmq rabbitmq

RUN apt-get update && apt-get install -y --no-install-recommends \
		rabbitmq-server \
	&& rm -rf /var/lib/apt/lists/*

RUN rabbitmq-plugins enable rabbitmq_management

WORKDIR /home/rabbitmq
COPY run_rabbitmq.sh /home/rabbitmq
COPY rabbitmq.conf /etc/supervisor/conf.d/rabbitmq.conf

RUN chown -R rabbitmq:rabbitmq /home/rabbitmq

EXPOSE 4369 5671 5672 15672

