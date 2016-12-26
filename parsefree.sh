# Read all .icns files in this folder
# Fix formatting, naming, and add them
# To an HTML page

OUTPUT_FILE="output.html"
FOLDER="icons"
> $OUTPUT_FILE

# For each one, retrieve the 256x256 png, fix the name, and add the formatted html to the output
for ICNS_FILE in $(ls -t "$FOLDER"/*.icns); do
    # Rename without spaces or capitals (ICNS_FILE is the file, ICNS_FILE_NAME is the basename)
    ICNS_FILE_RENAME=$(echo "$ICNS_FILE" | tr '[:upper:]' '[:lower:]')
    ICNS_FILE_RENAME="${ICNS_FILE_RENAME/ /_}"
    mv "$ICNS_FILE" "$ICNS_FILE_RENAME"
    ICNS_FILE="$ICNS_FILE_RENAME"
    ICNS_FILE_NAME=$(basename "$ICNS_FILE_RENAME" .icns)


    # Grab the 256x256 png
    iconutil --convert iconset "$ICNS_FILE"
    PNG_PATH="$FOLDER/${ICNS_FILE_NAME}.iconset/icon_128x128@2x.png"
    if [ ! -f "$PNG_PATH" ]; then
        PNG_PATH="$FOLDER/${ICNS_FILE_NAME}.iconset/icon_256x256.png"
    fi
    mv "$PNG_PATH" "$FOLDER/${ICNS_FILE_NAME}.png"
    PNG_PATH="$FOLDER/${ICNS_FILE_NAME}.png"
    rm -rf "$FOLDER/${ICNS_FILE_NAME}.iconset"

    # Add to output (literally the worst way to make html, but it works great)
    PRETTY_NAME=$(python -c "print '$ICNS_FILE_NAME'.replace(\"_\",\" \").title()")
    OUTPUT="<section class=\"small icon clickable\">
    <a href=\"$ICNS_FILE\" target=\"_blank\" rel=\"noopener noreferrer\">
        <img alt=\"$PRETTY_NAME\" src=\"$PNG_PATH\" />
    </a>
</section>"
    echo "$OUTPUT" >> $OUTPUT_FILE
done
