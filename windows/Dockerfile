# Stage 1: windows binary
FROM cdrx/pyinstaller-windows:python2 AS builder

WORKDIR /source
ADD requirements.txt epsonFiscalDriver.py /source/

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN pip install -r requirements.txt \
    && pyinstaller --clean -y --dist ./dist/windows --workpath /tmp --onefile epsonFiscalDriver.py

ENTRYPOINT ["bash"]

# Stage 2: service
FROM amake/innosetup AS packager

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        unzip

USER xclient

ADD windows /work
COPY --from=builder /source/dist /work/dist

RUN curl -fsSl -o nssm-2.24.zip https://nssm.cc/release/nssm-2.24.zip \
    && unzip nssm-2.24.zip \
    && cp nssm-2.24/win32/nssm.exe /work \
    && iscc epsonFiscalDriver.iss


# Stage 3: installer export
FROM alpine

WORKDIR /packages
COPY --from=packager /work/Output/*.exe /packages

ENTRYPOINT ["sh", "-c", "cp /packages/*.exe /output"]
