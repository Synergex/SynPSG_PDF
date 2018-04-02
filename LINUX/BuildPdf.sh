
#Set ROOT to the location of this script and put us in that folder
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $ROOT &> /dev/null

#Ensure we have a DBL environment
if [ ! -f $DBLDIR/bin/dbl ];
then
    echo ERROR: Cant find DBL. Have you executed setsde?
else
    #If there is no exe folder then create one
    if [ ! -d ./exe ];
    then
        mkdir exe
    fi

    #If there is no hdr folder then create one
    if [ ! -d ./hdr ];
    then
        mkdir hdr
    fi

    #If there is no obj folder then create one
    if [ ! -d ./obj ];
    then
        mkdir obj
    fi

    #If there is no out folder then create one
    if [ ! -d ./out ];
    then
        mkdir out
    fi

    #Set environment variables only used in this script
    PDF_SRC=$ROOT/../SOURCE/PDF
    PDX_SRC=$ROOT/../SOURCE/EXAMPLES
    OBJ=$ROOT/obj

    #Set environment variables used in and after this script
    export PDF_EXE=$ROOT/exe
    export SYNEXPDIR=$ROOT/hdr
    export SYNIMPDIR=$ROOT/hdr
    export OUTPUT=$ROOT/out
    export MEDIA=$ROOT/../MEDIA

    #Build the ELB
    echo
    echo Prototyping PDF code...
    dblproto $PDF_SRC/*.dbl
    echo Compiling PDF code...
    dbl -WD=762 -do $OBJ/SynPSG_PDF.dbo $PDF_SRC/*.dbl
    echo Linking executable library PDF_EXE:SynPSG_PDF.elb...
    dblink $DBG -dl PDF_EXE:SynPSG_PDF.elb $OBJ/SynPSG_PDF.dbo

fi

#Go back to the folder we were in before we were called
popd &> /dev/null

