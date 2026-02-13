#!/usr/bin/env sh

# Print file sizes
echo "w.min.full.js:  $(ls -l w.min.full.js | awk '{print $5}') bytes"
echo "w.min.lite.js:  $(ls -l w.min.lite.js | awk '{print $5}') bytes"
echo "w.min.full.zip: $(ls -l w.min.full.zip | awk '{print $5}') bytes"
echo "w.min.lite.zip: $(ls -l w.min.lite.zip | awk '{print $5}') bytes"
