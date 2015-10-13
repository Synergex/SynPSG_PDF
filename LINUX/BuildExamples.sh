
#Set ROOT to the location of this script and put us in that folder
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $ROOT &> /dev/null

#Ensure we have a DBL environment
if [ ! -f $DBLDIR/bin/dbl ];
then
    echo ERROR: Cant find DBL. Have you executed setsde?
else
    #Set environment variables only used in this script
    PDF_SRC=$ROOT/../SOURCE/EXAMPLES
    OBJ=$ROOT/obj

    #Set environment variables used in and after this script
    export PDF_EXE=$ROOT/exe
    export SYNIMPDIR=$ROOT/hdr

    #Build the sample programs
    echo
    echo Building example programs...
    for f in $PDF_SRC/*.dbl
    do
        FILE=`basename $f`
        echo - $FILE
        dbl -do $OBJ/${FILE%.dbl}.dbo $f
        dblink -do PDF_EXE:${FILE%.dbl}.DBR $OBJ/${FILE%.dbl}.dbo PDF_EXE:SynPSG_PDF.elb
    done
fi

#Go back to the folder we were in before we were called
popd &> /dev/null

