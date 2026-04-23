FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gnupg ca-certificates && \
    curl -fsSL http://neuro.debian.net/lists/noble.us-nh.full \
        -o /etc/apt/sources.list.d/neurodebian.sources.list && \
    curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x439754ED1F42AA2C" \
        | gpg --dearmor -o /usr/share/keyrings/neurodebian-archive-keyring.gpg && \
    sed -i 's|^deb |deb [signed-by=/usr/share/keyrings/neurodebian-archive-keyring.gpg] |' \
        /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends connectome-workbench && \
    rm -rf /var/lib/apt/lists/*
