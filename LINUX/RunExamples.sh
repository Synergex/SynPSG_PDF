
#Set ROOT to the location of this script and put us in that folder
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $ROOT &> /dev/null

#Ensure we have a DBL environment
if [ ! -f $DBLDIR/bin/dbl ];
then
    echo ERROR: Cant find DBL. Have you executed setsde?
else
    #Set environment variables used in and after this script
    export PDF_EXE=$ROOT/exe
    export OUTPUT=$ROOT/out
    export MEDIA=$ROOT/../MEDIA

    #Run the sample programs
    echo
    echo Running example programs...
    for f in $PDF_EXE/*.DBR
    do
        FILE=`basename $f`
        echo - $FILE
        dbr PDF_EXE:$FILE
    done

    echo
    echo Example PDF files are in the out folder
    echo
fi

#Go back to the folder we were in before we were called
popd &> /dev/null

