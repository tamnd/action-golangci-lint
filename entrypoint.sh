#!/bin/sh

cd "$GITHUB_WORKSPACE" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

# shellcheck disable=SC2086
echo "Reviewdog version: $(reviewdog -version)"
echo "GoglangCI-lint version: $(golangci-lint version)"

cd "${GITHUB_WORKSPACE}"/"${INPUT_WORKSPACE}" || exit 1
echo "Running on ${GITHUB_WORKSPACE}/${INPUT_WORKSPACE}"
ls

GO111MODULE=on golangci-lint run --out-format line-number ${INPUT_GOLANGCI_LINT_FLAGS} \
  | reviewdog -f=golangci-lint -name="${INPUT_TOOL_NAME}" -reporter=${INPUT_REPORTER:-github-pr-check} -level="${INPUT_LEVEL}"
