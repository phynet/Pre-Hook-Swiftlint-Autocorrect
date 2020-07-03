#!/bin/bash
echo "post-commit started"
# Run SwiftLint
START_DATE=$(date +"%s")

SWIFT_LINT=/usr/local/bin/swiftlint

# Run SwiftLint for given filename
exec_swiftlint() {
    local filename="${1}"
    echo "File is: ${filename}"
        if [[ "${filename##*.}" == "swift" ]]; then
            if [[ "${filename}" != "AutoMockable" ]]; then
            ${SWIFT_LINT} autocorrect --path "${filename}"
            ${SWIFT_LINT} lint --path "${filename}"
            fi
        fi
}

if [[ -e "${SWIFT_LINT}" ]]; then
    echo "SwiftLint version: $(${SWIFT_LINT} version)"
    # Run for both staged and unstaged files
    git diff --name-only | while read filename; do exec_swiftlint "${filename}"; done
    git diff --cached --name-only | while read filename; do run_swiftlint "${filename}"; done
else
    echo "${SWIFT_LINT} is not installed. Please install it first from https://www.github.com/realm/SwiftLint"
    exit 0
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "SwiftLint took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."

echo "post-commit finished"
