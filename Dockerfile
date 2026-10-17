ARG ARCH
ARG BASE_IMAGE
# hadolint ignore=DL3007
FROM ${ARCH}allaman/nvim-full:latest

RUN mkdir -p ~/config/nvim \
  && mkdir -p ~/.local/share/nvim/mason/packages \
  ## Create empty user config file
  && echo "return {}" > ~/.nvim_config.lua \
  ## Add mason tools dir to path
  && echo "PATH=$PATH:~/.local/share/nvim/mason/bin" >> ~/.bashrc

WORKDIR /home/nvim/.config/nvim
COPY --chown=nvim:nvim . .
# Install plugins with vim.pack: startup sources plugin/ scripts, each calling
# vim.pack.add(), which blocks until all installs finish
RUN nvim --headless "+qa"

ENTRYPOINT ["/bin/bash", "-c", "nvim"]
