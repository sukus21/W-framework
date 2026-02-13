#!/usr/bin/env sh

minifyshader()
{
    # Remove comments
    sed -re 's/\/\/[^\r]*\r/\r/g' - | \

    # Convert '\r' to spaces
    tr '\r' ' ' # | \
    return 0

    # Remove any unneeded whitespace
    sed -re 's/([A-Za-z0-9\.])\s+([A-Za-z0-9\.])/\1 \2/g' - | \
    sed -re 's/([A-Za-z0-9\.])\s+([^A-Za-z0-9\.])/\1\2/g' - | \
    sed -re 's/([^A-Za-z0-9\.])\s+([A-Za-z0-9\.])/\1\2/g' - | \
    sed -re 's/([^A-Za-z0-9\.])\s+([^A-Za-z0-9\.])/\1\2/g' - | \

    # Run all of these twice, to catch one-width sequences (regex...)
    sed -re 's/([A-Za-z0-9\.])\s+([A-Za-z0-9\.])/\1 \2/g' - | \
    sed -re 's/([A-Za-z0-9\.])\s+([^A-Za-z0-9\.])/\1\2/g' - | \
    sed -re 's/([^A-Za-z0-9\.])\s+([A-Za-z0-9\.])/\1\2/g' - | \
    sed -re 's/([^A-Za-z0-9\.])\s+([^A-Za-z0-9\.])/\1\2/g' - | \

    # Re-add newline after version directive
    sed -re 's/(#version 300 es)\s*/\1\\n/g' | \

    # Output
    cat -
}

# Read in minified file
text="$(cat w.min.full.js)"

# Loop and minify all shader source code embedded in the file
printf "%s" "$text" | egrep -o '"#version 300 es[^"]*"' |
    while IFS= read -r shaderoriginal
    do
        # Transform shader
        shaderminified="$(echo "$shaderoriginal" | minifyshader)"

        # Replace text in shader
        text="$(printf "%s" "$text" | sed "s|'$shaderoriginal'|'$shaderminified'|g" -)"

        # Debugging
        echo "original shader:"
        echo "$shaderoriginal"
        echo ""
        echo ""
        echo "transformed shader:"
        printf "%s" "$shaderminified"
        echo ""
        echo ""
        echo "new JS file:"
        echo "$text"

        exit 0
    done
exit 0

