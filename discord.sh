#!/bin/bash

if [[ "${DRONE_BUILD_STATUS}" == "success" ]]; then
    message="succeeded"
    color="65280"
    [[ -f screenshot.log ]] && screenshot_url=$(cat screenshot.log)
    [[ -n ${screenshot_url} ]] && screenshot_message="\n[screenshot](${screenshot_url})"
else
    message="failed"
    color="16711680"
fi

curl -fsSL -H "Content-Type: application/json" \
-X POST -d '{"embeds":[{"description":"Build **[#'"${DRONE_BUILD_NUMBER}"'](https://cloud.drone.io/'"${DRONE_REPO}"'/'"${DRONE_BUILD_NUMBER}"')** of `'"${DRONE_REPO//docker-/}"':'"${DRONE_COMMIT_BRANCH}"'` '"${message}"'.'"${screenshot_message}"'\n\nCommit **['"${DRONE_COMMIT_SHA:0:7}"']('"${DRONE_COMMIT_LINK}"')** by **'"${DRONE_COMMIT_AUTHOR}"'**:\n```'"${DRONE_COMMIT_MESSAGE//\"/}"'```","color":'"${color}"',"fields":[{"name":"Version","value":"'"${VERSION}"'"}]}]}' "https://discordapp.com/api/webhooks/${DISCORD_ID}/${DISCORD_TOKEN}"
