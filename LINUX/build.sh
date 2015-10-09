
#Ensure we have a DBL environment

if [ ! -f $DBLDIR/bin/dbl ];
then
    echo ERROR: Cant find DBL. Have you executed setsde?
    exit
fi

#Set ROOT to the location of this script and put us in that folder
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $ROOT &> /dev/null

if [ "`uname -i`" == "x86_64" ]
then
    BITNESS=64
else
    BITNESS=32
fi

if [ "$BITNESS" == "32" ] && [ ! -f ./32/libhpdf.so ];
then
    echo Extracting 32-bit HARU library...
    pushd 32 &> /dev/null
    tar -xf libhpdf_linux_32bit.tar
    if [ ! -f $DBLDIR/bin/libhpdf.so ];
    then
        echo Copying HARU PDF library to $DBLDIR/bin
        cp libhpdf.so $DBLDIR/bin
    fi
    popd &> /dev/null
fi

if [ "$BITNESS" == "64" ] && [ ! -f ./64/libhpdf64.so ];
then
    echo Extracting 64-bit HARU library...
    pushd 64 &> /dev/null
    tar -xf libhpdf_linux_64bit.tar
    if [ ! -f $DBLDIR/bin/libhpdf64.so ];
    then
        echo Copying HARU PDF library to $DBLDIR/bin
        cp libhpdf64.so $DBLDIR/bin
    fi
    popd &> /dev/null
fi

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
dbl -do $OBJ/SynPSG_PDF.dbo $PDF_SRC/*.dbl
echo Linking PDF code to PDF_EXE:SynPSG_PDF.elb...
dblink $DBG -dl PDF_EXE:SynPSG_PDF.elb $OBJ/SynPSG_PDF.dbo

#Build the sample programs
echo
echo Building example programs...
for f in $PDX_SRC/*.dbl
do
    FILE=`basename $f`
    echo - $FILE
    dbl -do $OBJ/${FILE%.dbl}.dbo $f
    dblink -do PDF_EXE:${FILE%.dbl}.DBR $OBJ/${FILE%.dbl}.dbo PDF_EXE:SynPSG_PDF.elb
done

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

#Go back to the folder we were in before we were called
popd &> /dev/null

