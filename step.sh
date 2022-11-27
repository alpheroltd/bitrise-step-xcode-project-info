#!/bin/bash

# ---------------------
# --- Exit if command fails

set -e

# ---------------------
# --- Main

if [ ! -z "${xcodeproj_path}" ]; then # use the xcode project path if present
	PROJECT_SPECIFIER="-project ${xcodeproj_path}"
	if [ -z "${target}" ]; then
		TARGET_SPECIFIER=""
	else
		TARGET_SPECIFIER="-target ${target}"
	fi
elif [ ! -z "${xcworkspace_path}" ]; then # otherwise try and use the path to the xcode workspace
	if [ ! -z "${scheme_name}" ]; then
		WORKSPACE_SPECIFIER="-workspace ${xcworkspace_path} -scheme ${scheme_name}"
	else
		echo "[ERROR] Attempting to use path to a workspace but no scheme name was provided."
		echo "$(xcrun xcodebuild -workspace ${xcworkspace_path} -list)"
		exit 1
	fi
else
	echo "[ERROR] No values given for xcodeproject_path or xcworkspace_path"
	echo "[ERROR] A 'Project path' or 'Workspace path' MUST be provided"
	exit 1
fi


PROJECT_SETTINGS=$(xcrun xcodebuild $PROJECT_SPECIFIER $TARGET_SPECIFIER $WORKSPACE_SPECIFIER -showBuildSettings)

version=$( echo "$PROJECT_SETTINGS" | grep "MARKETING_VERSION" | sed 's/[ ]*MARKETING_VERSION = //')
build=$( echo "$PROJECT_SETTINGS" | grep "CURRENT_PROJECT_VERSION" | sed 's/[ ]*CURRENT_PROJECT_VERSION = //')
resolved_target=$( echo "$PROJECT_SETTINGS" | grep "TARGET_NAME" | sed 's/[ ]*TARGET_NAME = //')

echo "[INFO] Resolved to target: ${resolved_target}"

envman add --key XPI_VERSION --value "${version}"
echo "[INFO] Version: ${version} -> Saved to \$XPI_VERSION environment variable."

envman add --key XPI_BUILD --value "${build}"
echo "[INFO] Build: ${build} -> Saved to \$XPI_BUILD environment variable."
