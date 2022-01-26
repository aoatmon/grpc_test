#! /bin/bash

for FILE in *.proto; do
    FOLDER=${FILE%.proto}
    mkdir -p $FOLDER
    if [ ! -d $FOLDER ] 
    then
        echo "Directory $FOLDER DOES NOT exists." 
        exit 9999
    fi
    protoc --proto_path=$DIR --dart_out=grpc:$FOLDER $FILE
    # touch "$FOLDER/all.dart"
    # cat >> "$FOLDER/all.dart" <<EOF
    # export 'foo.pb.dart';
    # export 'foo.pbenum.dart';
    # export 'foo.pbjson.dart';
    # export 'foo.pbserver.dart';
    # EOF
done