# Read all .icns files in this folder
# Fix formatting, naming, and add them
# To an HTML page

OUTPUT_FILE="output.html"
FOLDER="icons"
> $OUTPUT_FILE

# For each one, retrieve the 256x256 png, fix the name, and add the formatted html to the output
for PNG_PATH in $(ls -t "$FOLDER"/*.png); do
    # Rename without spaces or capitals (ICNS_FILE is the file, ICNS_FILE_NAME is the basename)
    PNG_FILE_NAME=$(basename "$PNG_PATH" .png)

    LINK="#"
    CLASS=""
    if [ -f "$FOLDER/$PNG_FILE_NAME.txt" ]; then
        LINK=`cat "$FOLDER/$PNG_FILE_NAME.txt"`
        CLASS=" clickable"
    fi

    # Add to output (literally the worst way to make html, but it works great)
    PRETTY_NAME=$(python -c "print '$PNG_FILE_NAME'.replace(\"_\",\" \").title()")
    OUTPUT="<section class=\"small icon$CLASS\">
    <a href=\"$LINK\" alt=\"$PRETTY_NAME\" target=\"_blank\" rel=\"noopener noreferrer\">
        <img src=\"$PNG_PATH\" />
    </a>
</section>"
    echo "$OUTPUT" >> $OUTPUT_FILE
done
