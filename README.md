# SynPSG_PDF

A platform-independent API that facilitates the easy creation of PDF files from
applications written in Synergy DBL. SynPSG_PDF extends earlier work presented
in PDFKIT from the Synergy/DE Code Exchange by presenting a more OO-like, more
friendly and generally more usable API.

Original author: Steve Ives, Synergex Professional Services Group

## Requirements

### Synergy/DE V10.3.1b or higher

In order to use the SynPSG_PDF classes you need both the source code (PDFDBL.DBL)
and HaruPDF shared libraries from PDFKIT. For your convenience we have included
both with this distribution.

### Microsoft Visual C++ 2010 Redistributable Package

To use this software on a system that does not have Visual Studio development
tools installed you may need to install this package. You should be able to
locate the required download easily using Google. Make sure you install the
appropriate x86 or x64 version as required.

## Documentation

The documentation for this API can be found in a Windows help file named SynPSG_PDF.chm
which you will find in the DOCUMENTATION folder.

If you open the file and don't see any content then you need to "unblock" the CHM file:

1. Right-click the CHM file and select "Properties" on the contxt menu.
2. On the "General" tab, click the "Unblock" button.
3. Click the "OK" button.

## Revision History

### 6th July 2016

* On Windows we Implemented the ability to define page backgrounds that are based on the content of a page in an existing PDF file. A background file might typically contain the layout of a "pre-printed" form, or perhaps a watermark image. A page background file is declared by calling the new SetBackgroundFile method and passing the name of an existing single-page PDF file to be used as the background. In order to use this feature you must install a copy of PDFtk Pro and its executable must be present in your system PATH.

### 5th July 2016

* Enhanced the SelectFont mechanism so that it won't fail if a null font name is passed. This could happen if the LoadTrueTypeFont method failed to load a font.

### 5th June 2016

* Hard-coded the name of the single prototype file created by the Windows Workbench environment as SynPsgPdfAPI.dbp. If you have existing prototype files (*.dbp) in the WINDOWS\hdr folder you will need to manually delete them in order to avoid DBL-E-TOKUDF errors during build.
* Re-organized the development environment by breaking apart the various members of the SynPSG.PDF namespace into various source files. Previously these members were all defined in a single source file named SynPSG_PDF.dbl, but that file was getting very large and somewhat difficult to manage.
* Updated various areas of the documentation.

### 19th May 2016

* Renamed the DrawMultiSeriesBarChart method to DrawBarChart.
* Removed the DrawSingleSeriesBarChart method because the exact same functionality can be achieved by calling the DrawBarChart method.
* Added a new overload of the DrawBarChart method that accepts positions passed using the XYcoordinate structure.
* Added a new method DrawBarChartRC that allows the position of a bar chart to be defined using row/column coordinates.
* Added a new overload of the DrawPieChart method that accepts positions passed using the XYcoordinate structure.
* Added a new overload of the DrawBox method that accepts positions passed using the XYcoordinate structure.
* Added a new overload of the DrawSingleSeriesChartLegend method that accepts positions passed using the XYcoordinate structure.
* Changed the YfromBodyRow method from private to public so that it can be used by consuming programs.
* Added a new OutlineRotText property.
* Updated some of the example routines.

### 28th March 2016

* Added support for drawing circles via a new method PdfFile.DrawCircle.
* Added support for drawing pie charts via a new method PdfFile.DrawPieChart.
* Added support for drawing bar charts via a new methods PdfFile.DrawSingleSeriesBarChart and  PdfFile.DrawMultiSeriesBarChart.
* Added support for drawing chart legends via a new methods PdfFile.DrawSingleSeriesChartLegend and PdfFile.DrawMultiSeriesChartLegend.

### 22nd March 2016

* Added a new static method PdfFile.PreviewFile that can be used to preview an existing PDF file. This method is only supported on Windows and requires that the PDF file extension is associated with a PDF viewer application such as Adobe Acrobat Reader or SumatraPDF.
* Added a new static method PdfFile.PrintFile that can be used to print an existing PDF file to a printer. This method is only supported on Windows and requires SumatraPDF to be installed.
* Added a new PdfFile.FileSpec property that can be used to access the full file spec of the PDF file that will be created once the Save method is called. The value of the property is equivalent to FileLocation + FileName.
* Added a new HaruDocument property that exposes the underlying PDFDBL document object. This enables PDFDBL functionality to be used directly if something is not directly supported by SynPSG.PDF.

### 15th October 2015

* Removed the earlier restrictions on VMS. As far as we know the code now works consistently between Windows, Linux and VMS.
* Added .NET support.
* Added a second constructor that allows a PDF file to be created from an existing text file.

### 9th October 2015

* Added support for Linux and VMS (with some restrictions, refer to known issues for more information).

### 11th September 2015

* Added the FixedPitchFont property.
* Modified the underlined text feature to use underscore characters to underline text when a fixed-pitch font is selected.

### 8th September 2015

* Added a new mechanism to allow you to determine whether a particular font is available for use by calling the new PdfFile.FontAvailable method.
* Added the ability to create document outlines. By default a document outline will be added, but you can disable the creation of an outline by setting the new property PdfFile.CreateOutline to false.
* Added the ability for you to specify custom document outline values for each page by passing a value to a new parameter of the PdfFile.NewPage method.
* Added the ability for you to control how documents are displayed in PDF viewers by setting the value of the new PdfFile.PageLayout property. Examples are to display the document one page at a time, full page width, two pages across, etc.
* Added a new mechanism to allow you to determine the initial display mode when a document is viewed in a PDF viewer application by setting the new PdfFile.PageMode property. This allows you to determine that the document should open with the thumbnails window or outline window visible, etc.
* Enabled document compression by default.

### 4th September 2015

* Added methods PdfFile.XfromColumn, PdfFile.YfromBodyRow, PdfFile.YfromFooterRow and PdfFile.YfromHeaderRow.

### 3rd September 2015

* Fixed an issue where using PdfFile.Row and PdfFile.Column for positioning (with PdfFile.DrawTextRC) before the first page is added would cause the output to be displayed one row too high on the page.
* Added support for direct printing via SumatraPDF.
* Added PdfFile.ColumnX and PdfFile.RowY properties.
* Added PdfFile.PrintDialog to allow printing to a printer selected by the user (requires SumatraPDF).
* Added the ability to insert additional space between rows when using row/column coordinates via a new parameter to the PdfFile constructor.
* Added basic support for underlined text.

### 1st September 2015

* Initial distribution.
