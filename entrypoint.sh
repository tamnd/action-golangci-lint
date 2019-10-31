#!/bin/bash

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

echo "Reviewdog version: $(reviewdog -version)"
echo "GoglangCI-lint version: $(golangci-lint version)"
cd ${GITHUB_WORKSPACE}/${INPUT_WORKSPACE}
GO111MODULE=on golangci-lint run --out-format line-number ${INPUT_GOLANGCI_LINT_FLAGS} \
  | reviewdog -f=golangci-lint -name="${INPUT_TOOL_NAME}" -reporter=github-pr-check -level="${INPUT_LEVEL}"
