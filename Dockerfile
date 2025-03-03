# Base Image 
FROM fedora:37

# 1. Setup home directory, non interactive shell and timezone
RUN mkdir -p /bot /tgenc && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Havana
ENV TERM=xterm

# 2. Install Dependencies
RUN dnf -qq -y upgrade --refresh && dnf -qq -y install git aria2 bash xz zstd wget curl pv jq python3-pip mediainfo psmisc procps-ng qbittorrent-nox gcc python3-devel && dnf clean all && python3 -m pip install --upgrade pip setuptools

# 3. Install latest ffmpeg and ab-av1
RUN wget -q https://github.com/Uranite/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-gpl-7.1.tar.xz && tar -xvf *xz && cp *7.1/bin/* /usr/bin && rm -rf ffmpeg* && wget -q https://github.com/alexheretic/ab-av1/releases/download/v0.9.1/ab-av1-v0.9.1-x86_64-unknown-linux-musl.tar.zst && tar -xvf *zst && cp ab-av1 /usr/bin && rm -rf ab-av1*

# 4. Copy files from repo to home directory
COPY . .

# 5. Install python3 requirements
RUN pip install -r requirements.txt && \
    pip cache purge

# 6. Cleanup
RUN rm -rf fonts scripts .env* .git* Dockerfile License *.md *.txt srun* update*
