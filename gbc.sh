#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BACKGROUND="$SCRIPT_DIR/background.png"
IMAGE_TO_CONVERT="$1"
BASE_NAME="$(basename ${IMAGE_TO_CONVERT%.*})"
GBC_UNSCALED=".unscaled-$BASE_NAME.png"
GBC_RESULT="gbc-$BASE_NAME.png"

convert "$IMAGE_TO_CONVERT" \
    -resize 128x112^ \
    -gravity center \
    -extent 128x112 \
    -colorspace Gray \
    -brightness-contrast 0x40 \
    -ordered-dither o8x8,4 \
    -scale 200% \
    +append \
    "$GBC_UNSCALED"

convert "$BACKGROUND" "$GBC_UNSCALED" \
    -gravity center \
    -composite \
    -scale 400% \
    "$GBC_RESULT"

rm $GBC_UNSCALED
