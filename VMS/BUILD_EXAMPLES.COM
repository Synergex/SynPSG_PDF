$ !
$ SET NOVERIFY
$ !
$ @SYNPSG_PDF_SETUP.COM
$ !
$ ! Build the example programs
$ !
$ WRITE SYS$OUTPUT ""
$ WRITE SYS$OUTPUT "Building example programs..."
$ EXAMPLES_LOOP:
$     FILE = F$SEARCH("PDF_EG_SRC:*.DBL")
$     IF FILE .EQS. "" THEN GOTO EXAMPLES_DONE
$     NAME = F$PARSE(FILE,,,"NAME")
$     CALL EXAMPLE_BUILD 'NAME
$     GOTO EXAMPLES_LOOP
$ !
$ EXAMPLES_DONE:
$ !
$ EXIT
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


