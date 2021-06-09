FROM dorowu/ubuntu-desktop-lxde-vnc:focal

RUN wget -O- http://neuro.debian.net/lists/focal.us-ca.full | \
    sudo tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    sudo apt-get update && \
    sudo apt-get install -y connectome-workbench
  
