#!/bin/bash

# Check if both arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <video_path> <interval_in_seconds>"
    echo "Example: $0 video.mp4 5"
    echo "This will extract an image every 5 seconds from the video"
    exit 1
fi

VIDEO_PATH="$1"
INTERVAL="$2"

# Get absolute path and filename
VIDEO_DIR="$(cd "$(dirname "$VIDEO_PATH")"; pwd)"
VIDEO_FILENAME="$(basename "$VIDEO_PATH")"
BASE_FILENAME="${VIDEO_FILENAME%.*}"

# Get video duration in seconds
DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$VIDEO_DIR/$VIDEO_FILENAME")
DURATION=${DURATION%.*}  # Remove decimal part

echo "Video duration: $DURATION seconds"
echo "Extracting images every $INTERVAL seconds..."

# Create output directory if it doesn't exist
OUTPUT_DIR="$VIDEO_DIR/${BASE_FILENAME}_frames"
mkdir -p "$OUTPUT_DIR"

# Extract frames at regular intervals
CURRENT_TIME=0
FRAME_COUNT=0

while [ $CURRENT_TIME -le $DURATION ]; do
    OUTPUT_FILENAME="${BASE_FILENAME}_$(printf "%04d" $FRAME_COUNT).png"
    ffmpeg -ss $CURRENT_TIME -i "$VIDEO_DIR/$VIDEO_FILENAME" -vframes 1 -q:v 2 "$OUTPUT_DIR/$OUTPUT_FILENAME" -y -loglevel error
    echo "Extracted: $OUTPUT_FILENAME at $CURRENT_TIME seconds"
    
    CURRENT_TIME=$((CURRENT_TIME + INTERVAL))
    FRAME_COUNT=$((FRAME_COUNT + 1))
done

echo "Extraction complete. $FRAME_COUNT images saved to $OUTPUT_DIR"
