#!/bin/bash

DATE=$(date '+%Y-%m-%d-%H:%M')
SOURCE="/dev/loop3" # wybrano małą partycję w celu wykonania szybkich testów skryptu
OUTPUT_IMAGE="./results/$DATE.img"
OUTPUT_FILE="./results/file-$DATE.txt"

if [ ! -e "$SOURCE" ]; then
    echo "Błąd: źródło '$SOURCE' nie istnieje."
    exit 1
fi

dd if="$SOURCE" of="$OUTPUT_IMAGE" bs=4M # status=progress

echo "$DATE" > "$OUTPUT_FILE"

ORIGINAL_SUM=$(sha256sum "$SOURCE" | awk '{print $1}')
IMAGE_SUM=$(sha256sum "$OUTPUT_IMAGE" | awk '{print $1}')

echo "Suma kontrolna oryginału: $ORIGINAL_SUM" >> "$OUTPUT_FILE"
echo "Suma kontrolna skopiowanego obrazu: $IMAGE_SUM" >> "$OUTPUT_FILE"

if [ "$ORIGINAL_SUM" = "$IMAGE_SUM" ]; then
    echo "Suma kontrolna się zgadza." >> "$OUTPUT_FILE"
else
    echo "UWAGA: Suma kontrolna się NIE zgadza!" >> "$OUTPUT_FILE"
fi

cat "$OUTPUT_FILE"