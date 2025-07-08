FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for kernel building
RUN apt-get update && apt-get install -y \
    bc \
    flex \
    bison \
    gcc \
    make \
    libelf-dev \
    libssl-dev \
    squashfs-tools \
    busybox-static \
    tree \
    cpio \
    curl \
    patch \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Copy kernel build scripts and configurations
COPY build.sh kernel_versions.txt ./
COPY configs/ ./configs/

# Make build script executable
RUN chmod +x build.sh

# Create builds directory
RUN mkdir -p builds

# Set the default command to run the build script
CMD ["./build.sh"]
