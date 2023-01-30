#!/bin/sh

# Metadata
export MDEV_CI="appcircle"

# Appcircle definitions
api_key=$AC_MAESTRO_API_KEY
app_file=$AC_MAESTRO_APP_FILE
workspace=$AC_MAESTRO_WORKSPACE
upload_name=$AC_MAESTRO_UPLOAD_NAME
async=$AC_MAESTRO_ASYNC
env=$AC_MAESTRO_ENV
android_api_level=$AC_MAESTRO_ANDROID_API_LEVEL
include_tags=$AC_MAESTRO_INCLUDE_TAGS
exclude_tags=$AC_MAESTRO_EXCLUDE_TAGS
export_test_report=$AC_MAESTRO_EXPORT_TEST_REPORT
export_output=$AC_MAESTRO_EXPORT_OUTPUT
mapping_file=$AC_MAESTRO_MAPPING_FILE
branch=$AC_MAESTRO_BRANCH
repo_name=$AC_MAESTRO_REPO_NAME
repo_owner=$AC_MAESTRO_REPO_OWNER
pull_request_id=$AC_MAESTRO_PULL_ID
maestro_cli_version=$AC_MAESTRO_CLI_VERSION

# Parse env variables
envs=$(echo $env | tr "\n" "\n")
env_list=""
for e in $envs
do
    env_list+="-e $e "
done

# Refine variables
[[ "$async" == "true" ]] && is_async="true"
[[ "$export_test_report" == "true" ]] && is_export="true"

# Test report file
if [[ "$is_export" == "true" ]]; then
    if [[ -z "$export_output" ]]; then
        export_file="report.xml"
    fi
fi

set -ex

# Change to source directory
cd $AC_REPOSITORY_DIR

# Maestro version
if [[ -z "$maestro_cli_version" ]]; then
    echo "Maestro CLI version not specified, using latest"
else
    echo "Maestro CLI version: $maestro_cli_version"
    export MAESTRO_VERSION=$maestro_cli_version;
fi

# Install maestro CLI
curl -Ls "https://get.maestro.mobile.dev" | bash
export PATH="$PATH":"$HOME/.maestro/bin"

# Run Maestro Cloud
EXIT_CODE=0

maestro cloud \
--apiKey $api_key \
${branch:+--branch "$branch"} \
${repo_name:+--repoName "$repo_name"} \
${repo_owner:+--repoOwner "$repo_owner"} \
${mapping_file:+--mapping "$mapping_file"} \
${upload_name:+--name "$upload_name"} \
${is_async:+--async} \
${pull_request_id:+--pullRequestId "$pull_request_id"} \
${android_api_level:+--android-api-level "$android_api_level"} \
${include_tags:+--include-tags "$include_tags"} \
${exclude_tags:+--exclude-tags "$exclude_tags"} \
${is_export:+--format "junit"} \
${export_file:+--output "$export_file"} \
${env_list:+ $env_list} \
$app_file $workspace || EXIT_CODE=$?

# Export test results
if [[ -n "$export_file" && -f "$export_file" ]]; then
    test_run_dir="$AC_OUTPUT_DIR/maestro"
    mkdir "$test_run_dir"
    cp "$export_file" "$test_run_dir/maestro_report.xml"
fi

exit $EXIT_CODE