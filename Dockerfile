FROM python:3-alpine

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
    bash

RUN pip install \
        jinja2 \
        jsonmerge

RUN ln -sf /bin/bash /bin/sh
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

COPY resources/merge-values /usr/local/bin/merge-values
RUN chown root:root /usr/local/bin/merge-values && \
    chmod 755 /usr/local/bin/merge-values

COPY resources/populate /usr/local/bin/populate
RUN chown root:root /usr/local/bin/populate && \
    chmod 755 /usr/local/bin/populate

ENTRYPOINT ["/bin/bash"]
