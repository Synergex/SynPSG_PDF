
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

if [ "$BITNESS" == "32" ] && [ -f libhpdf_linux_32bit.tar ];
then
    echo Extracting the 32-bit libHaru shared object library...
    pushd 32 &> /dev/null
    tar -xf libhpdf_linux_32bit.tar
    if [ -f libhpdf.so ];
    then
        echo Copying shared object libhpdf.so library to $DBLDIR/bin
        cp libhpdf.so $DBLDIR/bin
    fi
    popd &> /dev/null
fi

if [ "$BITNESS" == "64" ] && [ -f 64/libhpdf_linux_64bit.tar ];
then
    echo Extracting the 64-bit libHaru shared object library...
    pushd 64 &> /dev/null
    tar -xf libhpdf_linux_64bit.tar
    if [ -f libhpdf64.so ];
    then
        echo Copying shared object libhpdf64.so library to $DBLDIR/bin
        cp libhpdf64.so $DBLDIR/bin
    fi
    popd &> /dev/null
fi

#Go back to the folder we were in before we were called
popd &> /dev/null

