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
    > w.full.min.js

# Build the lite version
terser w.js \
    --compress \
    --mangle \
    --define W.built=true \
    --define W.plugin.debug=false \
    --define W.plugin.smooth=false \
    --define W.plugin.builtinShapes=false \
    > w.lite.min.js

# Zip both files
zip -9 w.full.min.zip w.full.min.js
zip -9 w.lite.min.zip w.lite.min.js

# Print file sizes
echo "w.full.min.js:  $(ls -l w.full.min.js | awk '{print $5}') bytes"
echo "w.lite.min.js:  $(ls -l w.lite.min.js | awk '{print $5}') bytes"
echo "w.full.min.zip: $(ls -l w.full.min.zip | awk '{print $5}') bytes"
echo "w.lite.min.zip: $(ls -l w.lite.min.zip | awk '{print $5}') bytes"
