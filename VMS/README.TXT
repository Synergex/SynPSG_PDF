
Follow these instructions to build and run the software provided in this
environment:

Editing the Setup Procedure
---------------------------
The supplied environment includes a DCL command procedure named
SYNPSG_PDF_SETUP.COM which defines the environment in which SynPSG_PDF can be
built and executed. By default this procedure is configured assuming that you
are running Synergy/DE 10.3.1 or higher. If you are running an older version of
Synergy then you will need to edit the file and reverse the comment characters
on the following two lines:

        $ !VERSION = "953B"
        $ VERSION = "1031"

Extract the libHaru Files
-------------------------
The next step is to extract the required libHaru shared image binaries. These
binaries are provided inside ZIP files in the [.AXP.953B], [.AXP.1031],
[.IA64.953B] and [.IA64.1031] directories; you will only use one of these sets
of files based on your system type (AXP or IA64) and Synergy version. There are
two shared images:

        LIBHPDF.EXE
        PDFDBL.EXE

To make extracting the required libHaru shared image binaries easy we have
provided a DCL command procedure named EXTRACT.COM that extracts the required
shared images. Execute the command procedure like this:

        @EXTRACT.COM

You should see output like this (for a 64-bit system):

        Extracting AXP images for Synergy 9.5.3b...

        Archive: DEV:[SynPSG_PDF.VMS.AXP.953b]libhpdf_vms_axp.zip;1
         inflating: libhpdf_vms_axp.bck
        %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.953b]README.TXT;1
        %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.953b]LIBHPDF.EXE;1
        %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.953b]PDFDBL.EXE;1

        Extracting AXP images for Synergy 10.3.1...

        Archive: DEV:[SynPSG_PDF.VMS.AXP.1031]libhpdf_vms_axp.zip;1
         inflating: libhpdf_vms_axp.bck
        %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.1031]README.TXT;1
        %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.1031]LIBHPDF.EXE;1
        %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.1031]PDFDBL.EXE;1

        Replacing MEDIA files with OpenVMS versions...

        Archive: DEV:[SynPSG_PDF.VMS]VMSMEDIA.ZIP;1
         inflating: [-.media]arialn.ttf
         inflating: [-.media]arialnb.ttf
        extracting: [-.media]sdelogo.png

Note that the libHaru shared image libraries that you link against are runtime
components and must be shipped along with your application binaries.

Building SynPSG_PDF
-------------------
The SynPSG_PDF environment consists of a number of classes and enumerations
that can be manipulated in order to create PDF files. The code for these
classes and enumerations can be found in a source named SynPSG_PDF.DBL. This
source file is located in the directory [SYNPSG_PDF.SOURCE.PDF].

To build the SynPSG_PDF shared image on your system, go to the
[.SYNPSG_PDF.VMS] folder and execute the command procedure BUILD_PDF.COM:

        @BUILD_PDF.COM

You should see output like this:

        Compiling PDF code...
        Creating object library...
        Building and running MAKESHARE...
        Created SYNPSG_PDF.COM

        Linking shared image PDF_EXE:SYNPSG_PDF.EXE

Building and Running the Sample Programs
----------------------------------------
The SynPSG_PDF environment includes several example programs that show how to
use various features of the SynPSG_PDF environment. The source code for the
example programs is in the directory [.SYNPSG_PDF.SOURCE.EXAMPLES]. To build
and run the sample programs:

        @BUILD_EXAMPLES.COM

You should see output like this:

        Building example programs...
        - Building AUTOITEMS
        - Building BLUEANDREDBOX
        - Building DBLMESSAGESREPORT
        - Building DELIVERYTICKET
        - Building DESIGNGRID
        - Building HEADERBODYFOOTER
        - Building LANDSCAPE132
        - Building MIXEDPAGEORIENTATION
        - Building PORTRAIT100

Then execute the script to run the example programs:

        @RUN_EXAMPLES.COM

You should see output like this:

        Running example programs...
        - Building AUTOITEMS
        - Building BLUEANDREDBOX
        - Building DBLMESSAGESREPORT
        - Building DELIVERYTICKET
        - Building DESIGNGRID
        - Building HEADERBODYFOOTER
        - Building LANDSCAPE132
        - Building MIXEDPAGEORIENTATION
        - Building PORTRAIT100

        Example PDF files are in the out folder

Each of the example programs creates a PDF file and the PDF file will be
displayed using the default application that you have registered to open PDF
files. The PDF files that are created are located in the directory
[.SYNPSG_PDF.VMS.OUT].

Incorporating SynPSG_PDF into your Development Environment
----------------------------------------------------------
Before you can use the SynPSG_PDF classes from within your own code base you
will need to do two things:

1.Make the strong prototyping header files available in your development
  environment.

2.Link against PDF_EXE:SYNPSG_PDF.EXE

Prototype Files
---------------
Because SynPSG_PDF is implemented vi an OO API it is mandatory that you
prototype the code and provide those prototypes to the compiler when compiling
application code that uses the API. The supplied environment already creates
the required prototype files, you will find them in the directory
[.SYNPSG.PDF.VMS.HDR] so it is simply a case of making them available in your
development environment. This can be achieved by specifying the
"import directory" by setting the SYNIMPDIR environment variable to include the
path to the [.SYNPSG.PDF.VMS.HDR] directory. SYNIMPDIR is a "search list"
logical that supports several paths being specified separated by commas, so if
you already have it set in your environment then simply add the path to the
[.SYNPSG.PDF.VMS.HDR] directory; if not then set it for the first time.

Another option is to change the location where the supplied environment creates
the prototype files in the first place, to a location where other prototype
files already exist for your environment. You could do that by editing the
SYNPSG_PDF_SETUP.COM command procedure and changing the values for both the
SYNEXPDIR and SYNIMPDIR logical name definitions.

Link against the SYNPSG_PDF.EXE Shared Image
--------------------------------------------
Having built the SynPSG_PDF environment (above) you will find the resulting
shared image in a folder that is pointed to by the PDF_EXE: logical name. You
will find a linker options file named SYNPSG_PDF.OPT in the [.SYNPSG_PDF.VMS]
directory, and you can use this options file to link your programs against the
libHaru and SynPSG_PDF shared images, like this:

        $ DIB/OPT MYPROGRAM.DBL
        $ LINK MYPROGRAM,SYNPSG_PDF/OPT,SYS$SHARE:SYNRTL/OPT

