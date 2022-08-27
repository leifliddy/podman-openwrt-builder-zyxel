FROM registry.fedoraproject.org/fedora:36

ENV imagebuilder openwrt-imagebuilder-22.03.0-rc6-ipq806x-generic.Linux-x86_64.tar.xz
ENV imagebuilder_url https://downloads.openwrt.org/releases/22.03.0-rc6/targets/ipq806x/generic/openwrt-imagebuilder-22.03.0-rc6-ipq806x-generic.Linux-x86_64.tar.xz

RUN dnf upgrade -y &&\
    dnf install -y bzip2 ccache diffutils file findutils gcc git perl-File-Compare perl-File-Copy perl-FindBin perl-Thread-Queue rsync unzip vim-enhanced wget which xz &&\
    wget $imagebuilder_url -P /tmp &&\
    mkdir -p /root/openwrt &&\
    tar --strip-components=1 -xvf /tmp/$imagebuilder --directory=/root/openwrt &&\
    rm -rf /tmp/$imagebuilder &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    sed -i '/^alias rm.*$/d' /root/.bashrc &&\
    sed -i '/^alias cp.*$/d' /root/.bashrc &&\
    sed -i '/^alias mv.*$/d' /root/.bashrc &&\
    echo -e "\nalias vi='vim'" >> ~/.bashrc &&\
    echo 'defaultyes=True' >> /etc/dnf/dnf.conf

# set login directory
WORKDIR /root

CMD ["/bin/bash"]
