FROM phusion/baseimage:latest

RUN dpkg --add-architecture i386 && \
    apt-get -y update && \
    apt-get -y upgrade
    apt install -y \
    build-essential \
    libc6-dbg \
    lib32stdc++6 \
    g++-multilib \
    cmake \
    gcc \
    ipython \
    vim \
    net-tools \
    curl \
    libffi-dev \
    libssl-dev \
    python-dev \
    build-essential \
    tmux \
    glibc-source \
    cmake \
    strace \
    ltrace \
    nasm \
    socat\
    netcat\
    wget \
    radare2 \
    gdb \
    gdb-multiarch \
    netcat \
    socat \
    git \
    patchelf \
    gawk \
    file \
    zsh \
    qemu \
    bison --fix-missing  \
    gcc-multilib \
    binwalk \
    libseccomp-dev \
    libseccomp2 \
    seccomp \
    proxychains \
    openssh-server \
    lrzsz \


RUN apt-get -f install -y \
    gcc-5-arm-linux-gnueabi \
    gcc-5-aarch64-linux-gnu \
    gcc-5-powerpc64le-linux-gnu \
    gcc-5-powerpc64-linux-gnu \
    gcc-5-powerpc-linux-gnu \
    gcc-5-mips64el-linux-gnuabi64 \
    gcc-5-mips64-linux-gnuabi64 \
    gcc-5-mipsel-linux-gnu  \
    gcc-5-mips-linux-gnu &&\
    rm -rf /var/lib/apt/list/**

RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt update &&\
    apt install -y ruby2.6 &&\
    apt install -y ruby2.6-dev

RUN ulimit -c 0
RUN gem install one_gadget 
RUN gem install seccomp-tools 

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN python3 -m pip install -U pip && \
    python3 -m pip install --no-cache-dir \
    -i https://pypi.doubanio.com/simple/  \
    --trusted-host pypi.doubanio.com \
    ropper \
    unicorn \
    capstone

RUN pip install --upgrade setuptools && \
    pip install --no-cache-dir \
    -i https://pypi.doubanio.com/simple/  \
    --trusted-host pypi.doubanio.com \
    ropgadget \
    pwntools \
    zio \
    smmap2 \
    z3-solver \
    apscheduler && \
    pip install --upgrade pwntools



# Oh-my-zsh
RUN chsh -s /bin/zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN git clone https://github.com/scwuaptx/Pwngdb.git /root/Pwngdb && \
    cd /root/Pwngdb && cat /root/Pwngdb/.gdbinit  >> /root/.gdbinit && \
    sed -i "s?source ~/peda/peda.py?# source ~/peda/peda.py?g" /root/.gdbinit

RUN git clone https://github.com/TacXingXing/peda.git ~/peda && \
    cp ~/peda/.inputrc ~/

RUN git clone https://github.com/niklasb/libc-database.git libc-database && \
    cd libc-database && ./get || echo "/libc-database/" > ~/.libcdb_path

RUN git clone https://github.com/pwndbg/pwndbg && \
    cd pwndbg &&  ./setup.sh

# Vim-config
RUN git clone https://github.com/Tacxingxing/vimrc && \
    cd vimrc && chmod u+x install.sh && ./install.sh && cd ..

WORKDIR /ctf/work/

COPY --from=skysider/glibc_builder64:2.19 /glibc/2.19/64 /glibc/2.19/64
COPY --from=skysider/glibc_builder32:2.19 /glibc/2.19/32 /glibc/2.19/32

COPY --from=skysider/glibc_builder64:2.24 /glibc/2.24/64 /glibc/2.24/64
COPY --from=skysider/glibc_builder32:2.24 /glibc/2.24/32 /glibc/2.24/32

COPY --from=skysider/glibc_builder64:2.26 /glibc/2.26/64 /glibc/2.26/64
COPY --from=skysider/glibc_builder32:2.26 /glibc/2.26/32 /glibc/2.26/32

COPY --from=skysider/glibc_builder64:2.27 /glibc/2.27/64 /glibc/2.27/64
COPY --from=skysider/glibc_builder32:2.27 /glibc/2.27/32 /glibc/2.27/32

COPY --from=skysider/glibc_builder64:2.28 /glibc/2.28/64 /glibc/2.28/64
COPY --from=skysider/glibc_builder32:2.28 /glibc/2.28/32 /glibc/2.28/32

COPY --from=skysider/glibc_builder64:2.29 /glibc/2.29/64 /glibc/2.29/64
COPY --from=skysider/glibc_builder32:2.29 /glibc/2.29/32 /glibc/2.29/32

COPY --from=skysider/glibc_builder64:2.30 /glibc/2.30/64 /glibc/2.30/64
COPY --from=skysider/glibc_builder32:2.30 /glibc/2.30/32 /glibc/2.30/32

COPY --from=skysider/glibc_builder64:2.31 /glibc/2.31/64 /glibc/2.31/64
COPY --from=skysider/glibc_builder32:2.31 /glibc/2.31/32 /glibc/2.31/32

# COPY linux_server linux_server64  /ctf/
COPY zshrc /root/.zshrc
COPY tmux.conf /root/.tmux.conf
COPY gdbinit /root/.gdbinit

# RUN chmod a+x /ctf/linux_server /ctf/linux_server64

ENTRYPOINT ["/bin/zsh"]
