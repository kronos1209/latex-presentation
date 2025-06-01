FROM mcr.microsoft.com/devcontainers/base:ubuntu24.04


# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    texlive-lang-japanese texlive-latex-extra texlive-luatex \
    latexmk texlive-extra-utils

# Set up working user
WORKDIR /workspace