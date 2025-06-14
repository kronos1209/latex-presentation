FROM buildpack-deps:bullseye-scm

# texlive をインストールするためのミラーサイト
ARG TEXLIVE_MIRROR=https://mirror.ctan.org/systems/texlive/tlnet

# tlmgr がインストールしたバイナリのパスを通す
# TODO: 現在 texlive.profile 上で texlive のパスを変更しているが、インストールした texlive のバージョンのディレクトリにある bin ディレクトリへのリンクを /usr/local/textlive/bin に配置するほうがいいかも
ENV PATH=${PATH}:/usr/local/texlive/bin/x86_64-linux

# apt dependencies
RUN apt update \
    && apt install -y python3-pip evince cpanminus

# minted パッケージでコードのハイライトを行う際に必要
# TODO: Python をインストールするだけで動作しているように見える。要調査
RUN pip3 install pygments

WORKDIR /install-texlive

COPY ./texlive.profile .

# texlive のインストール
RUN mkdir tmp \
    && curl -L ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz | tar -xz  --strip-components 1 -C tmp \
    && ./tmp/install-tl -profile texlive.profile --location ${TEXLIVE_MIRROR} 

# latexident に必要なのでインストール
RUN cpanm install YAML::Tiny File::HomeDir

# 必要な package のインストール
# MEMO: tlmgr のパッケージが一番変更しそうないので最後のレイヤに配置しておく
# TODO: 必要最低限のパッケージだけをインストールするようにしたい。特に collection-latexextra はかなり大きなパッケージなので分割できるならば分割したい
RUN tlmgr install minted \
    collection-binextra \
    collection-langjapanese \
    collection-luatex \
    collection-fontsrecommended \
    collection-latexextra \
    collection-pictures \
    collection-bibtexextra 