#!/bin/bash
set -euo pipefail

IMAGE_REF="$1"
MAX_LAYERS=100

echo "==> Chunkifying $IMAGE_REF..."

# Get config from existing image
CONFIG=$(podman inspect "$IMAGE_REF")

# Run chunkah (default 64 layers) and pipe to podman load
# Uses --mount=type=image to expose the source image content to chunkah
# Note: We need --privileged for some podman-in-podman/mount scenarios or just standard access
LOADED=$(podman run --rm \
    --security-opt label=type:unconfined_t \
    --mount=type=image,src="$IMAGE_REF",dest=/chunkah \
    -e "CHUNKAH_CONFIG_STR=$CONFIG" \
    quay.io/jlebon/chunkah:latest build --max-layers $MAX_LAYERS | podman load)

echo "$LOADED"

# Parse the loaded image reference
NEW_REF=$(echo "$LOADED" | grep -oP '(?<=Loaded image: ).*' || \
          echo "$LOADED" | grep -oP '(?<=Loaded image\(s\): ).*')

if [ -n "$NEW_REF" ] && [ "$NEW_REF" != "$IMAGE_REF" ]; then
    echo "==> Retagging chunked image to $IMAGE_REF..."
    podman tag "$NEW_REF" "$IMAGE_REF"
fi
