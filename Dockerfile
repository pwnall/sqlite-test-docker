FROM ubuntu:disco

RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90nouser && \
    echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90nouser && \
    ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update -qq && \
    apt-get upgrade -qq -y && \
    DEBIAN_FRONTEND=noniteractive apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg && \
    curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/disco/ llvm-toolchain-disco-8 main" \
        >> /etc/apt/sources.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noniteractive apt-get install -y --no-install-recommends \
        clang-8 gcc-9 libicu-dev make tcl8.6-dev && \
    dpkg-reconfigure --frontend noninteractive tzdata
