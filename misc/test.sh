#!/usr/bin/env bash
# SPDX-License-Identifier: LGPL-3.0-or-later
#
# Smoke test for a built image: start a container, wait until the server
# reports healthy and check that it serves the expected LanguageTool version.
#
# usage: misc/test.sh <image> <expected-version>

set -Eeuo pipefail

if [ "$#" -ne 2 ]; then
    echo "usage: $0 <image> <expected-version>" >&2
    exit 2
fi

IMAGE=$1
EXPECTED_VERSION=$2
PORT=${TEST_PORT:-8010}
TIMEOUT=${TEST_TIMEOUT:-180}
BASEURL="http://127.0.0.1:${PORT}/v2"
CONTAINER="languagetool-test-$$"

fail() {
    echo "FAIL: $*" >&2
    echo "--- container logs ---" >&2
    docker logs "$CONTAINER" >&2 2>&1 || true
    exit 1
}

cleanup() {
    docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
}
trap cleanup EXIT

check() {
    curl -fsS \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --header 'Accept: application/json' \
        --data "text=hello%20woorld&language=$1&motherTongue=de-DE&enabledOnly=false" \
        "${BASEURL}/check"
}

echo ":: starting $IMAGE as $CONTAINER on port $PORT"
docker run -d --pull never --name "$CONTAINER" -p "127.0.0.1:${PORT}:8010" "$IMAGE" >/dev/null

echo ":: waiting up to ${TIMEOUT}s for the server"
deadline=$((SECONDS + TIMEOUT))
until curl -fsS "${BASEURL}/healthcheck" >/dev/null 2>&1; do
    if [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINER")" != "true" ]; then
        fail "container exited before the server became ready"
    fi
    if [ "$SECONDS" -ge "$deadline" ]; then
        fail "server not ready after ${TIMEOUT}s"
    fi
    sleep 2
done

echo ":: GET /v2/languages"
languages=$(curl -fsS --header 'Accept: application/json' "${BASEURL}/languages") \
    || fail "GET /v2/languages failed"
for code in en-US fr; do
    jq -e --arg c "$code" 'any(.[]; .longCode == $c)' <<<"$languages" >/dev/null \
        || fail "language $code not offered"
done

echo ":: POST /v2/check (en-US)"
result=$(check en-US) || fail "POST /v2/check en-US failed"
version=$(jq -r '.software.version' <<<"$result")
[ "$version" = "$EXPECTED_VERSION" ] \
    || fail "server reports version '$version', expected '$EXPECTED_VERSION'"
jq -e '.matches | length > 0' <<<"$result" >/dev/null \
    || fail "no match for 'woorld' in en-US"

echo ":: POST /v2/check (fr)"
check fr >/dev/null || fail "POST /v2/check fr failed"

echo "PASS: $IMAGE serves LanguageTool $version"
