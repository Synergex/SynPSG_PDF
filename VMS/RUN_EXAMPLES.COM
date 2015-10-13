$ !
$ SET NOVERIFY
$ !
$ @SYNPSG_PDF_SETUP.COM
$ !
$ ! Eun the example programs
$ !
$ WRITE SYS$OUTPUT ""
$ WRITE SYS$OUTPUT "Running example programs..."
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
$ !
$ EXIT
$ !
$ !----------------------------------------------------------------------------
$ ! SUBROUTINES
$ !
$ EXAMPLE_RUN: SUBROUTINE
$ WRITE SYS$OUTPUT " - Running ''P1'"
$ RUN PDF_EXE:'P1.EXE
$ EXIT
$ ENDSUBROUTINE
$ !
$ !----------------------------------------------------------------------------

