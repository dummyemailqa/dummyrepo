#!/bin/sh
processes=4

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
        pabot --processes $processes --pabotlib --resourcefile accountdataset.dat --testlevelsplit --argumentfile1 run-chrome.txt --argumentfile2 run-edge.txt -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml ${1:-test}
    ;;
    Darwin*)
        python3 -m pabot --processes $processes --pabotlib --resourcefile accountdataset.dat --testlevelsplit --argumentfile1 run-chrome.txt --argumentfile2 run-edge.txt -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml ${1:-test}

    ;;
    MINGW*)
        pabot --processes $processes --pabotlib --resourcefile accountdataset.dat --testlevelsplit --argumentfile1 run-chrome.txt --argumentfile2 run-edge.txt -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml ${1:-test}
    ;;
    Msys*)
        pabot --processes $processes --pabotlib --resourcefile accountdataset.dat --testlevelsplit --argumentfile1 run-chrome.txt --argumentfile2 run-edge.txt -v isHeadless:true -d $OUTDIR --output $DAY$MONTH$YEAR-alltestcase.xml ${1:-test}
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