ARG ARCH
ARG BASE_IMAGE
FROM ${ARCH}allaman/nvim-full:latest

RUN mkdir -p .config/nvim \
  && mkdir -p .local/share/nvim/mason/packages \
  ## Create empty user config file
  && echo "return {}" > .nvim_config.lua \
  ## Add mason tools dir to path
  && echo "PATH=$PATH:~/.local/share/nvim/mason/bin" >> ~/.bashrc

COPY --chown=nvim:nvim . .config/nvim
# Install plugins and tools with Mason and go.nvim
# HACK: Use of sleep is not cool but commands are not blocking (! is not working either)
RUN nvim --headless "+Lazy! sync" +qa
  # && nvim --headless "+Lazy! load mason.nvim +MasonInstall +sleep 45" +qa

ENTRYPOINT ["/bin/bash", "-c", "nvim"]
