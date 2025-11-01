#!/usr/bin/env bash

imageday="$1"
imagenight="$2"
outputname="$3"

echo "Creating $outputname for macOS"

filename=$(basename -- "$imageday")
extension="${filename##*.}"

mkdir -p output/$outputname/macos

# Check if wallpapper is installed
if ! command -v wallpapper &> /dev/null; then
    echo "wallpapper not found. Installing via Homebrew..."
    brew tap mczachurski/wallpapper
    brew install wallpapper
fi

# Convert to PNG first
magick "$imageday" "/tmp/$outputname-day.png"
magick "$imagenight" "/tmp/$outputname-night.png"

# Create wallpapper config JSON (must be an array at root level)
cat > /tmp/$outputname-config.json <<EOF
[
  {
    "fileName": "$outputname-day.png",
    "isPrimary": false,
    "isForLight": true,
    "isForDark": false,
    "altitude": 27.95,
    "azimuth": 135.0
  },
  {
    "fileName": "$outputname-night.png",
    "isPrimary": false,
    "isForLight": false,
    "isForDark": true,
    "altitude": -0.34,
    "azimuth": 90.0
  }
]
EOF

# Create dynamic wallpaper with wallpapper
cd /tmp
wallpapper -i "$outputname-config.json" -o "$outputname.heic"
cd -

# Move the generated dynamic wallpaper
mv "/tmp/$outputname.heic" "output/$outputname/macos/$outputname.heic"

# Also keep PNG versions for manual use
cp "/tmp/$outputname-day.png" "output/$outputname/macos/$outputname-day.png"
cp "/tmp/$outputname-night.png" "output/$outputname/macos/$outputname-night.png"

# Clean up
rm "/tmp/$outputname-day.png" "/tmp/$outputname-night.png" "/tmp/$outputname-config.json"
