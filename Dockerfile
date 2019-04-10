#
# Glances Dockerfile based on Alpine OS
#
# https://github.com/nicolargo/glances
#

# Pull base image.
FROM python:3.6-alpine

# Install build deps and Glances (develop branch)

COPY requirements.txt .

RUN apk add --no-cache --virtual .build-deps \
		linux-headers \
		gcc \
		g++ \
		libc-dev \
		git \
	&& git clone -b develop https://github.com/nicolargo/glances.git \
	&& cd glances \
	&& pip install -r requirements.txt \
	&& apk del .build-deps

# Define working directory.
WORKDIR /glances
 
ENV PYTHONUNBUFFERED 1

# EXPOSE PORT (For XMLRPC)
EXPOSE 61209

# EXPOSE PORT (For Web UI)
EXPOSE 61208

# Define default command.
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT
