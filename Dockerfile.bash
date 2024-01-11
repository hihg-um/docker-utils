# SPDX-License-Identifier: GPL-2.0
ARG BASE_IMAGE
FROM $BASE_IMAGE

LABEL org.opencontainers.image.description="Bash package"

ARG RUN_CMD

# analytics package target - we want a new layer here, since different
# dependencies will have to be installed, sharing the common base above
RUN DEBIAN_FRONTEND=noninteractive apt -y install bash

ARG TEST="/test.sh"
COPY --chmod=0555 src/test/$RUN_CMD.sh ${TEST}

ARG ENTRY="/entrypoint.sh"
RUN echo "#!/bin/bash\n$RUN_CMD \$@" > ${ENTRY} && chmod ugo+rx ${ENTRY}
ENTRYPOINT [ "/entrypoint.sh" ]
