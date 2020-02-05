#!/bin/bash

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
  LOG_FILE=$TEST_DIR/logs/$PLATFORM/$DESIGN\_$DESIGN_NICKNAME.log
  GOLD_LOG_FILE=$TEST_DIR/gold_logs/$PLATFORM/$DESIGN\_$DESIGN_NICKNAME.log
fi


set -o pipefail

mkdir -p $TEST_DIR/logs/$PLATFORM

if which innovus &> /dev/null; then
  TARGETS="finish drc congestion"
else
  echo "INFO: No innovus installation detected; skipping third-party DRC"
  TARGETS="finish"
fi

make -C $TEST_DIR/.. DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_CONFIG.mk clean_all
make -C $TEST_DIR/.. DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_CONFIG.mk $TARGETS 2>&1 | tee $LOG_FILE


#diff $LOG_FILE $GOLD_LOG_FILE
