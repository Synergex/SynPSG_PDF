
Name:           SynPSG_PDF

Author:         Steve Ives, Synergex Professional Services Group

Description:    A collection of Synergy DBL classes that facilitate the easy
                creation of PDF files. SynPSG.PDF extends the work done in
                PDFKIT from the Synergy Code Exchange by presenting a more
                OO-like, more friendly and generally more usable API. And
                SynPSG_PDF also includes documentation!

Requirements:   SynPSG_PDF requires Synergy/DE V10.3.1b or higher

                In order to use the SynPSG_PDF classes you need both the source
                code (PDFDBL.DBL) and HaruPDF shared libraries from PDFKIT. For
                your convenience we have included both with the SynPSG.PDF
                distribution.

--------------------------------------------------------------------------------

IMPORTANT NOTE:	Because of changes to the prototype file format between Synergy
                versions 10.3.1 and 10.3.3, this example ships wioth no prototype
                files created. This means that you will need to build both the
                ELB and Application projects before attempting to run the sample\
                code.

                Also, when you build the ELB under 10.3.3 you will currently see
                the following warning:

                "pdfdbl.dbl"(394):            if (^passed(detail_no)) then
                %DBL-W-INVPASSED, ^PASSED on required parameter is always true

                This is because of an issue in the underlying PDFDBL code which
                is maintained by Synergex development. The issue has been
                reported to them and will be addressed at some point, but
                it is currently safe to ignore the warning and proceed.

--------------------------------------------------------------------------------

For additional information please refer to the documentation which you will
find in DOCUMENTATION\SynPSG_PDF.chm

--------------------------------------------------------------------------------
