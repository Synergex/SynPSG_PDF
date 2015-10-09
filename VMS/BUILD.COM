$ !
$ SET NOVERIFY
$ !
$ @SYNPSG_PDF_SETUP.COM
$ !
$ WRITE SYS$OUTPUT ""
$ WRITE SYS$OUTPUT "Prototyping PDF code..."
$ !
$ IF (F$SEARCH("SYNEXPDIR:*.DBP") .NES. "") THEN DELETE/NOLOG/NOCONF SYNEXPDIR:*.DBP;*
$ DBLPROTO PDF_SRC:*.DBL
$ !
$ WRITE SYS$OUTPUT "Compiling PDF code..."
$ DIB/OPT/OBJ=PDF_OBJ:SYNPSG_PDF.OBJ PDF_SRC:SynPSG_PDF.DBL
$ !
$ WRITE SYS$OUTPUT "Creating object library..."
$ LIB/CREATE PDF_OBJ:SYNPSG_PDF.OLB
$ LIB/INSERT PDF_OBJ:SYNPSG_PDF.OLB PDF_OBJ:SYNPSG_PDF.OBJ
$ !
$ WRITE SYS$OUTPUT "Building and running MAKESHARE..."
$ DIB/OPT/OBJ=PDF_OBJ:MAKESHARE.OBJ PDF_ROOT:MAKESHARE.DBL
$ LINK/EXE=PDF_EXE:MAKESHARE.EXE PDF_OBJ:MAKESHARE.OBJ,SYS$SHARE:SYNRTL/OPT
$ MAKESHARE:==$PDF_EXE:MAKESHARE.EXE
$ WRITE SYS$OUTPUT ""
$ !
$ MAKESHARE -L PDF_OBJ:SYNPSG_PDF.OLB -SI PDFDBL -E PDF_EXE:
$ !
$ @SYNPSG_PDF.COM
$ !
$ ! Now build the example programs
$ !
$ WRITE SYS$OUTPUT ""
$ WRITE SYS$OUTPUT "Building sample programs..."
$ EXAMPLES_LOOP:
$     FILE = F$SEARCH("PDF_EG_SRC:*.DBL")
$     IF FILE .EQS. "" THEN GOTO EXAMPLES_DONE
$     NAME = F$PARSE(FILE,,,"NAME")
$     CALL EXAMPLE_BUILD 'NAME
$     GOTO EXAMPLES_LOOP
$ !
$ EXAMPLES_DONE:
$ !
$ ! And finally run the example programs
$ !
$ WRITE SYS$OUTPUT ""
$ WRITE SYS$OUTPUT "Running sample programs..."
$ RUN_LOOP:
$     FILE = F$SEARCH("PDF_EXE:*.EXE")
$     IF FILE .EQS. "" THEN GOTO RUN_DONE
$     NAME = F$PARSE(FILE,,,"NAME")
$     IF ("''NAME'".EQS."LIBHPDF").OR.("''NAME'".EQS."MAKESHARE").OR.("''NAME'".EQS."PDFDBL").OR.("''NAME'".EQS."SYNPSG_PDF") THEN GOTO RUN_LOOP
$     CALL EXAMPLE_RUN 'NAME
$     GOTO RUN_LOOP
$ !
$ RUN_DONE:
$ !
$ WRITE SYS$OUTPUT ""
$ WRITE SYS$OUTPUT "Example PDF files are in the OUT folder"
$ WRITE SYS$OUTPUT ""
echo
$ GOTO DONE
$ !
$ !----------------------------------------------------------------------------
$ ! SUBROUTINES
$ !
$ EXAMPLE_BUILD: SUBROUTINE
$ WRITE SYS$OUTPUT " - Building ''P1'"
$ DIB/OPT/OBJ=PDF_OBJ:'P1.OBJ PDF_EG_SRC:'P1.DBL
$ LINK/EXE=PDF_EXE:'P1.EXE PDF_OBJ:'P1.OBJ,PDF_ROOT:SYNPSG_PDF/OPT,SYS$SHARE:SYNRTL/OPT
$ EXIT
$ ENDSUBROUTINE
$ !
$ EXAMPLE_RUN: SUBROUTINE
$ WRITE SYS$OUTPUT " - Running ''P1'"
$ RUN PDF_EXE:'P1.EXE
$ EXIT
$ ENDSUBROUTINE
$ !
$ !----------------------------------------------------------------------------
$ DONE:
$ !
$ EXIT

