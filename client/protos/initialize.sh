#! /bin/bash

SOURCE=source

for FILE in "$SOURCE"/*.proto; do
    NAME="$(basename "$FILE" .proto)"
    FOLDER=lib/src/$NAME
    mkdir -p "$FOLDER"
    protoc --proto_path=$SOURCE --dart_out=grpc:"$FOLDER" "$FILE"
    echo "export '$NAME/all.dart';" >> lib/src/all.dart
    touch "$FOLDER"/all.dart
    for GENERATED in "$FOLDER/$NAME".*.dart; do
        if test -f "$GENERATED"; then
            EXPORT="$(basename "$GENERATED")"
            echo "export '$EXPORT';" >> "$FOLDER"/all.dart
        fi
    done
done