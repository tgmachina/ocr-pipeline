# OCR pipeline with tesseract

### Prerequisites

* File system, cloud or otherwise
* tesseract installed

### Usage

`img_to_text_pdf source destination`

### Description

Takes images from one directory, runs tesseract OCR on them, and outputs
the encoded pdf to a destination directory.

I wrote this to be used in conjunction with a cloud based file system
(like owncloud or dropbox) such that the workflow looks like:

1. Take picture with app that straigtens image (Microsoft Office Lens)
2. Saves image to owncloud directory on phone
3. Script runs in cron on directory on remote server/computer
4. Run elastic search over the target directory to enable search (TODO).
