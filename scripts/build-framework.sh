#! /usr/bin/env bash
FF_PLATFORM=$1
PROJECT_NAME="SGPlayer"
TARGET_NAME="SGPlayer $FF_PLATFORM"
CONFIGURATION="Release"
BUILD_DIR="build/framework"
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

# Make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Next, work out if we're in SIM or DEVICE
xcodebuild -target "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=YES BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
# remove arm64 in simulator.
lipo "${BUILD_DIR}"/"${CONFIGURATION}"-iphonesimulator/"${PROJECT_NAME}".framework/SGPlayer -remove arm64 -output "${BUILD_DIR}"/"${CONFIGURATION}"-iphonesimulator/"${PROJECT_NAME}".framework/SGPlayer
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

# mv "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${TARGET_NAME}.framework" "${BUILD_DIR}/${
#     CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework"
# mv "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${TARGET_NAME}.framework" "${BUILD_DIR}/${
#     CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework"

cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}"
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/." "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"

lipo -create -output "${BUILD_DIR}/${CONFIGURATION}-universal/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"

open "${UNIVERSAL_OUTPUTFOLDER}"