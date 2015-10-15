
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
    echo Building examples...
    dblibr -c $OBJ/PdfTests.olb
    for f in $PDF_SRC/*.dbl
    do
        FILE=`basename $f`

        if [ ! "$FILE" == "PdfTest.dbl" ];
        then
            echo - $FILE
            dbl -do $OBJ/${FILE%.dbl}.dbo $f
            dblibr -a $OBJ/PdfTests.olb $OBJ/${FILE%.dbl}.dbo
        fi

    done

    echo
    echo Building test program PDF_EXE:PdfTest.dbr...
    echo
    dbl -do $OBJ/PdfTest.dbo $PDF_SRC/PdfTest.dbl
    dblink -do PDF_EXE:PdfTest.dbr $OBJ/PdfTest.dbo $OBJ/PdfTests.olb PDF_EXE:SynPSG_PDF.elb

fi

#Go back to the folder we were in before we were called
popd &> /dev/null

