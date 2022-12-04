FROM registry.fedoraproject.org/fedora:37

ENV imagebuilder openwrt-imagebuilder-22.03.0-ipq806x-generic.Linux-x86_64.tar.xz
ENV imagebuilder_url https://downloads.openwrt.org/releases/22.03.0/targets/ipq806x/generic/openwrt-imagebuilder-22.03.0-ipq806x-generic.Linux-x86_64.tar.xz

COPY files/bashrc /root/.bashrc

RUN dnf upgrade -y &&\
    dnf install -y bzip2 ccache diffutils file findutils gcc git perl-File-Compare perl-File-Copy perl-FindBin perl-Thread-Queue rsync unzip vim-enhanced wget which xz &&\
    mkdir /root/.bashrc.d &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo 'defaultyes=True' >> /etc/dnf/dnf.conf &&\
    wget $imagebuilder_url -P /tmp &&\
    mkdir -p /root/openwrt &&\
    tar --strip-components=1 -xvf /tmp/$imagebuilder --directory=/root/openwrt &&\
    rm -rf /tmp/$imagebuilder

# set login directory
WORKDIR /root

CMD ["/bin/bash"]
