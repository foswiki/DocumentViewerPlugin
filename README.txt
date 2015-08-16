Document Viewer Plugin for Foswiki

Embed presentations, spreadsheets, PDFs and other documents

The Document Viewer Plugin allows you to use presentations, spreadsheets, PDFs and other documents in Foswiki without any external dependencies. No tricks, no conversions, no unexpected downtime from external services, and no plugins required – it happens to work just fine in all major browsers today.

Document Viewer Plugin uses viewerjs, which makes use of pdf.js and webodf to perform the rendering.

Supported formats

    Open Document Format
    Portable Document Format (PDF) 

Installation
You do not need to install anything in the browser to use this extension. The following instructions are for the administrator who installs the extension on the server.

Open configure, and open the "Extensions" section. Use "Find More Extensions" to get a list of available extensions. Select "Install".

If you have any problems, or if the extension isn't available in configure, then you can still install manually from the command-line. See http://foswiki.org/Support/ManuallyInstallingExtensions for more help.

Example

%DOCUMENTVIEWER{"presentation.pdf"}%

Info

Dependencies: None 
