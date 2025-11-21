# Use Debian slim for reliable package installation
FROM debian:bookworm-slim

# Install frotz (Z-machine interpreter)
RUN apt-get update && \
    apt-get install -y frotz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user to run the game (frotz won't run as root)
RUN useradd -m -s /bin/bash zork

# Create directory for the game
WORKDIR /game

# Copy the compiled game file
COPY COMPILED/zork1.z3 /game/

# Change ownership to the zork user
RUN chown -R zork:zork /game

# Switch to non-root user
USER zork

# Run the game when the container starts
CMD ["/usr/games/frotz", "zork1.z3"]
