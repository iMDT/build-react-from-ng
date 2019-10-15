#!/bin/bash
ARGUMENT_LIST=(
    "configuration"
    "output-path"
)


# read arguments
opts=$(getopt \
    --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
    --name "$(basename "$0")" \
    --options "" \
    -- "$@"
)

eval set --$opts

while [[ $# -gt 0 ]]; do
    case "$1" in
        --configuration)
            configuration=$2
            shift 2
            ;;

        --output-path)
            outputPath=$2
            shift 2
            ;;

        *)
            break
            ;;
    esac
done


echo configuration: $configuration
echo outputPath: $outputPath
set -e
echo "Building ..."
npm run-script build

set +e
echo "Copying ..."
mkdir dist/ &> /dev/null
rm -rf $outputPath &> /dev/null

set -e
mv build $outputPath

echo "Ok"
