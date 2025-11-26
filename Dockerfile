# Use Debian slim for reliable package installation
FROM debian:bookworm-slim

# Install frotz (Z-machine interpreter)
RUN apt-get update && \
    apt-get install -y frotz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user to run the game (security best practice for containers)
RUN useradd -m -s /bin/bash zork

# Create directory for the game and save files
RUN mkdir -p /game /saves && chown -R zork:zork /game /saves

# Copy the compiled game file
COPY --chown=zork:zork COMPILED/zork1.z3 /game/

# Switch to non-root user
USER zork

# Set saves directory as working directory (frotz saves to current directory)
WORKDIR /saves

# Volume for persistent save files
VOLUME /saves

# Run the game when the container starts
CMD ["/usr/games/frotz", "/game/zork1.z3"]
