# Appcircle _Maestro Cloud Upload_ component

Upload both your app binary and flows to Maestro Cloud.

## Required Inputs

- `AC_MAESTRO_API_KEY`: API key. Maestro Cloud API key
- `AC_MAESTRO_APP_FILE`: App File. **Android**: `app_file` should point to an x86 compatible APK file. **iOS**: `app_file` should point to an x86 compatible Simulator build packaged in a zip archive.
- `AC_MAESTRO_WORKSPACE`: Flow file or directory. By default, the action is looking for a .maestro folder with Maestro flows in the root directory of the project. If you would like to customize this behaviour, you can override it with a workspace argument

## Optional Inputs

- `AC_MAESTRO_UPLOAD_NAME`: Upload Name. Custom upload name
- `AC_MAESTRO_ASYNC`: Async Mode. Run in async mode
- `AC_MAESTRO_ENV`: Environment variables. Pass environment variables to your flows
- `AC_MAESTRO_ANDROID_API_LEVEL`: Android api level. Set the Android api level the devices should run (Default: 30)
- `AC_MAESTRO_INCLUDE_TAGS`: Include tags. Run only flows that contain the specified tags (comma separated) i.e dev,pull-request
- `AC_MAESTRO_EXCLUDE_TAGS`: Exclude tags. Exclude flows from running with the specified tags (comma separated) i.e pull-request,experimental
- `AC_MAESTRO_EXPORT_TEST_REPORT`: Export test report (JUnit). Generate test suite report (JUnit)
- `AC_MAESTRO_EXPORT_OUTPUT`: Export test output. Export test file output (Default: report.xml)
- `AC_MAESTRO_MAPPING_FILE`: Mapping File. **Android**: Include the Proguard mapping file to deobfuscate Android performance traces.**iOS**: Include the generated .dSYM file (unique per build)
- `AC_MAESTRO_BRANCH`: Build branch. The branch this upload originated from
- `AC_MAESTRO_REPO_NAME`: Repository name. Repository name (ie: GitHub repo slug)
- `AC_MAESTRO_REPO_OWNER`: Repository owner. Repository owner (ie: GitHub organization or user slug)
- `AC_MAESTRO_PULL_ID`: Pull request id. The ID of the pull request this upload originated from
- `AC_MAESTRO_CLI_VERSION`: Maestro CLI version. Maestro CLI version to be downloaded in your CI (Default: latest)
