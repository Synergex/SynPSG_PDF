
To build and test SynPSG_PDF on VMS:

1. Execute the EXTRACT procedure, like this:

   @EXTRACT.COM

   The output you will see will depend on whether you are using an AXP or IA64
   system. For example, on an AXP system you will see something lie this:

      Extracting AXP images for Synergy 9.5.3b...
      Archive:  DEV:[SynPSG_PDF.VMS.AXP.953b]libhpdf_vms_axp.zip;1
        inflating: libhpdf_vms_axp.bck
      %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.953b]README.TXT;1
      %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.953b]LIBHPDF.EXE;1
      %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.953b]PDFDBL.EXE;1
      Extracting AXP images for Synergy 10.3.1...
      Archive:  DEV:[SynPSG_PDF.VMS.AXP.1031]libhpdf_vms_axp.zip;1
        inflating: libhpdf_vms_axp.bck
      %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.1031]README.TXT;1
      %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.1031]LIBHPDF.EXE;1
      %BACKUP-S-CREATED, created DEV:[SynPSG_PDF.VMS.AXP.1031]PDFDBL.EXE;1

2. Next execute the BUILD procedure, like this:

   @BUILD.COM

   You should see output similar to this:

      Prototyping PDF code...
      Compiling PDF code...
      Creating object library...
      Building and running MAKESHARE...
      Created SYNPSG_PDF.COM

      Linking shared image SYNPSG_PDF_EXE:SYNPSG_PDF.EXE

      Building sample programs...
       - Building AUTOITEMS
       - Building BLUEANDREDBOX
       - Building DBLMESSAGESREPORT
       - Building DELIVERYTICKET
       - Building DESIGNGRID
       - Building HEADERBODYFOOTER
       - Building LANDSCAPE132
       - Building MIXEDPAGEORIENTATION
       - Building PORTRAIT100

      Running sample programs...
       - Running AUTOITEMS
       - Running BLUEANDREDBOX
       - Running DBLMESSAGESREPORT
       - Running DELIVERYTICKET
       - Running DESIGNGRID
       - Running HEADERBODYFOOTER
       - Running LANDSCAPE132
       - Running MIXEDPAGEORIENTATION
       - Running PORTRAIT100

      Example PDF files are in the OUT folder

3. Look in the "out" folder for the PDF files that were created.
