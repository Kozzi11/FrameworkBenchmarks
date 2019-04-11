FROM dlang2/ldc-ubuntu:1.15.0

RUN apt update -y && apt install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*

ADD ./ /hunt
WORKDIR /hunt

RUN git clone https://github.com/nodejs/http-parser.git && \
    cd http-parser && \
    make package

RUN dub upgrade --verbose
RUN dub build -f --arch=x86_64 --build=release-nobounds --compiler=ldc2 -c=lite

CMD ["./hunt-minihttp"]
