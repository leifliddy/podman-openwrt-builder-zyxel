FROM registry.fedoraproject.org/fedora:39

ENV imagebuilder openwrt-imagebuilder-23.05.2-ipq806x-generic.Linux-x86_64.tar.xz
ENV imagebuilder_url https://downloads.openwrt.org/releases/23.05.2/targets/ipq806x/generic/openwrt-imagebuilder-23.05.2-ipq806x-generic.Linux-x86_64.tar.xz

COPY files/bashrc /root/.bashrc

RUN dnf upgrade -y &&\
    dnf install -y bzip2 ccache diffutils file findutils gcc git patch perl-File-Compare perl-File-Copy perl-FindBin perl-Thread-Queue python3-setuptools rsync unzip vim-enhanced wget which xz &&\
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
