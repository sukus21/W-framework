#!/usr/bin/env sh

# Check if Terser is available on the user's system
if ! command -v terser > /dev/null 2>&1
then
    echo '"terser" is not installed.'
    echo 'run "sudo npm install terser -g" to install it.'
    exit 1
fi

# Build the full version
terser w.js \
    --compress \
    --mangle \
    --define W.built=true \
    --define W.plugin.debug=false \
    --define W.plugin.smooth=true \
    --define W.plugin.builtinShapes=true \
    > w.min.full.js
zip -9 -q w.min.full.zip w.min.full.js
./ect-0.8.3.exe -9 -zip -quiet "w.min.full.zip"

# Build the lite version
terser w.js \
    --compress \
    --mangle \
    --define W.built=true \
    --define W.plugin.debug=false \
    --define W.plugin.smooth=false \
    --define W.plugin.builtinShapes=false \
    > w.min.lite.js
zip -9 -q w.min.lite.zip w.min.lite.js
./ect-0.8.3.exe -9 -zip -quiet "w.min.lite.zip"

# Print file sizes
echo "w.min.full.js:  $(ls -l w.min.full.js | awk '{print $5}') bytes"
echo "w.min.lite.js:  $(ls -l w.min.lite.js | awk '{print $5}') bytes"
echo "w.min.full.zip: $(ls -l w.min.full.zip | awk '{print $5}') bytes"
echo "w.min.lite.zip: $(ls -l w.min.lite.zip | awk '{print $5}') bytes"
