# SPDX-License-Identifier: GPL-3.0
ARG BASE
FROM $BASE

# build-args
ARG BASE
ARG RUN_CMD
ARG BUILD_REPO

RUN apt -y update -qq && \
    DEBIAN_FRONTEND=noninteractive apt -y install \
    --no-install-recommends --no-install-suggests \
    bash \
    && \
	apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/*

ARG TEST="/test.sh"
COPY --chmod=0555 src/test/$RUN_CMD.sh ${TEST}

ARG ENTRY="/entrypoint.sh"
RUN echo "#!/bin/bash\n$RUN_CMD \$@" > ${ENTRY} && chmod ugo+rx ${ENTRY}
ENTRYPOINT [ "/entrypoint.sh" ]

LABEL org.opencontainers.image.base.name="${BASE}"
LABEL org.opencontainers.image.description="Utilities: ${RUN_CMD}"
LABEL org.opencontainers.image.url="${BUILD_REPO}"