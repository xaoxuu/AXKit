#!/bin/bash --login


#Verify variable is provided
if [ "$1" = "" ]; then
        echo -e "Version number not provide"
        exit 1
fi

FILENAME="AXKit.podspec"
VERSION=$1

sed -i "" "s/\([0-9]\)\.\([0-9]\)\.\([0-9]\)/${VERSION}/g" ${FILENAME}
git add --all
git commit -am "${VERSION}" 
git push origin
git tag ${VERSION}
git push --tags
pod lib lint
# pod trunk push ${FILENAME}


# pod trunk push AXKit.podspec




# if [ "$1" = "" ]; then
#         echo -e "File not provide"
#         exit 1
# fi
# if [ "$2" = "" ]; then
#         echo -e "Version number not provide"
#         exit 1
# fi

# FILENAME=$1
# VERSION=$2

# cd /Users/scow/GitHub/Lib3Framework-iOS/ 
# sed -i "" "s/\([0-9]\)\.\([0-9]\)\.\([0-9]\)/${VERSION}/g" ${FILENAME}