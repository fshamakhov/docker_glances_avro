#
# Glances Dockerfile based on Alpine OS
#
# https://github.com/nicolargo/glances
#

# Pull base image.
FROM python:3.6-alpine

# Install build deps and Glances (develop branch)

RUN apk add --no-cache --virtual .build-deps \
		linux-headers \
		gcc \
		g++ \
		libc-dev \
		git \
	&& git clone -b develop https://github.com/nicolargo/glances.git

# Define working directory.
WORKDIR /glances
 
COPY requirements.txt .

RUN pip install -r requirements.txt \
	&& apk del .build-deps

ENV PYTHONUNBUFFERED 1

# EXPOSE PORT (For XMLRPC)
EXPOSE 61209

# EXPOSE PORT (For Web UI)
EXPOSE 61208

# Define default command.
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT
