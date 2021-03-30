#!/bin/bash -ex

# Setting args (and setting default values for testing)
DESIGN_CONFIG=${1:-gcd}
PLATFORM=${2:-nangate45}

# TODO: Currently assumes this script must be called from the flowdir.
TEST_DIR=${TEST_DIR:-test}

if [ -z "$DESIGN_NICKNAME" ]
then
  LOG_FILE=$TEST_DIR/logs/$PLATFORM/$DESIGN_CONFIG.log
  GOLD_LOG_FILE=$TEST_DIR/gold_logs/$PLATFORM/$DESIGN_CONFIG.log
else
  LOG_FILE=$TEST_DIR/logs/$PLATFORM/$DESIGN/$DESIGN_NICKNAME.log
  GOLD_LOG_FILE=$TEST_DIR/gold_logs/$PLATFORM/$DESIGN/$DESIGN_NICKNAME.log
fi


set -o pipefail

mkdir -p $TEST_DIR/logs/$PLATFORM

if [ -f "../../private_tool_scripts/util/utils.mk" ]; then
  TARGETS="finish metadata drc_calibre"
else
  TARGETS="finish metadata"
fi

make -C $TEST_DIR/.. DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_CONFIG/config.mk clean_all clean_metadata

# turn off abort on error so we can always capture the result
set +e

make -C $TEST_DIR/.. DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_CONFIG/config.mk $TARGETS 2>&1 | tee $LOG_FILE

# Save the return code to return as the overall status after we package
# the results
ret=$?
set -e

if [ ! -z ${MAKE_ISSUE+x} ]; then
  make -C $TEST_DIR/.. DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_CONFIG/config.mk final_report_issue
fi

exit $ret
