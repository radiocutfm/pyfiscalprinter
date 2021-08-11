# Stage 1: linux binary
FROM ubuntu:16.04 AS builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        python-dev \
        build-essential \
    && apt-get install -y python \
    && curl -fSsl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o /get-pip.py \
    && python /get-pip.py

WORKDIR /source
COPY requirements.txt epsonFiscalDriver.py /source/

RUN pip install -r requirements.txt \
    && pip install 'pyinstaller<4.0' \
    && pyinstaller --clean -y --dist ./dist/linux --workpath /tmp --onefile epsonFiscalDriver.py


ENTRYPOINT ["bash"]


# Stage 2: package
FROM ubuntu:16.04 AS packager

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        fakeroot \
        ca-certificates \
        curl \
    && curl -fsSL -o /makeself-2.4.2.run https://github.com/megastep/makeself/releases/download/release-2.4.2/makeself-2.4.2.run \
    && chmod +x /makeself-2.4.2.run \
    && /makeself-2.4.2.run --target /usr/local/bin

COPY linux /work/linux
COPY --from=builder /source/dist /work/dist

WORKDIR /work
RUN mkdir -p /work/package \
    && cp -rp dist/linux package/epsonFiscalDriver \
    && cp linux/epsonFiscalDriver@.service package/epsonFiscalDriver \
    && cp linux/startFiscalService package/epsonFiscalDriver \
    && cp linux/default.conf package/epsonFiscalDriver \
    && cp linux/README package/epsonFiscalDriver \
    && cp -rp linux/setup package \
    && makeself.sh package epsonFiscalDriver.run "Servicio epsonFiscalDriver" ./setup

ENTRYPOINT ["bash"]

# Stage 3: installer export
FROM alpine

WORKDIR /packages
COPY --from=packager /work/epsonFiscalDriver.run /packages

ENTRYPOINT ["sh", "-c", "cp /packages/*.run /output"]
