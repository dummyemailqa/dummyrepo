#!/bin/sh

DAY=$(date +"%d")
MONTH=$(date +"%b")
YEAR=$(date +"%Y")
TIME=$(date +"%H%M%S")

TEST_TIME=$DAY$MONTH$YEAR

unameOut=$(uname -a)

case "${unameOut}" in
    Linux*)
        OUTDIR=results/$MONTH/$TEST_TIME/$TIME
        LOG_PATH=$OUTDIR/report.html
    ;;
    Darwin*)
        cd "$(dirname "$0")"
        OUTDIR=results/$MONTH/$TEST_TIME/$TIME
        LOG_PATH=$OUTDIR/report.html
    ;;
    *)
        OUTDIR=results\\$MONTH\\$TEST_TIME\\$TIME
        LOG_PATH=$OUTDIR\\report.html
    ;;
esac

case "${unameOut}" in
    Linux*)
        pabot --pabotlib --resourcefile accountdataset.dat -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml test
    ;;
    Darwin*)
        python3 -m pabot --pabotlib --resourcefile accountdataset.dat -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml test

    ;;
    MINGW*)
        pabot --pabotlib --resourcefile accountdataset.dat -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml test
    ;;
    Msys*)
        pabot --pabotlib --resourcefile accountdataset.dat -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml test
    ;;
    *)              
        echo "UNKNOWN SISTEM OPERATION: ${unameOut}"
    ;;
esac

case "${unameOut}" in
    Linux*)
        xdg-open $LOG_PATH
    ;;
    Darwin*)
        open $LOG_PATH
    ;;
    Msys*)
        explorer $LOG_PATH
    ;;
    MINGW*)
        explorer $LOG_PATH
    ;;
    *)
        echo "Result: $LOG_PATH"
    ;;
esac