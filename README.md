# Connectome Workbench

This is a Dockerfile that sets up the HCP [Connectome Workbench](https://humanconnectome.org/software/connectome-workbench) (via [NeuroDebian](https://neuro.debian.net/pkgs/connectome-workbench.html)) in an [Ubuntu 20.04 desktop](https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/), accessible via HTTP.

Install: `docker pull jflournoy/connectome-workbench`
Run: `docker run -p 6080:80 -v /dev/shm:/dev/shm jflournoy/connectome-workbench`

Then point your browser to `127.0.0.1:6080`.

It might be useful to download the [HCP Tutorial data](https://balsa.wustl.edu/study/kN3mg) and attach it:

```
docker run -p 6080:80 -v /dev/shm:/dev/shm -v /location/of/hcp/data:/data jflournoy/connectome-workbench
```