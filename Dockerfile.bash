# SPDX-License-Identifier: GPL-3.0
ARG BASE
FROM $BASE

# build-args
ARG BASE
ARG RUN_CMD
ARG BUILD_REPO
ARG BUILD_TIME

RUN apt -y update -qq && DEBIAN_FRONTEND=noninteractive apt -y install \
	--no-install-recommends --no-install-suggests \
		bash \
	&& \
	apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/*

COPY --chmod=0555 src/test/${RUN_CMD}.sh /test.sh

ENTRYPOINT [ "bash -c" ]

LABEL org.opencontainers.image.base.digest=""
LABEL org.opencontainers.image.base.name="${BASE}"
LABEL org.opencontainers.image.created="$BUILD_TIME"
LABEL org.opencontainers.image.description="Docker Utilities: ${RUN_CMD}"
LABEL org.opencontainers.image.title="${RUN_CMD}"
LABEL org.opencontainers.image.url="${BUILD_REPO}"
