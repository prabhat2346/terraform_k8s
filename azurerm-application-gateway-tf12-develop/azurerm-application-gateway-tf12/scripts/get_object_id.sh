#!/bin/bash

echo {\"object_id\": "$(az ad sp show --id $1 | jq .objectId)" }
