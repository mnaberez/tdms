# TDMS for Ruby

TDMS is a binary file format for measurement data.  It was created
by National Instruments.

 - [NI TDMS File Format](http://zone.ni.com/devzone/cda/tut/p/id/3727)
 - [TDMS File Format Internal Structure](http://zone.ni.com/devzone/cda/tut/p/id/5696)

National Instruments software such as LabVIEW, DIAdem, and Measurement
Studio support reading and writing TDMS files.  NI also provides a DLL
written in C for using TDMS files on Windows.

TDMS for Ruby was written to provide a convenient way to work with
TDMS files on Unix-like platforms.

## Current State

This library is very early in development but is complete enough to
read the example TDMS file that comes with NI DIAdem.

 - Segments with interleaved measurements are not yet supported.
 - Segments with big endian data are not yet supported.
 - Writing TDMS files is not yet supported.

## Contributors

[Mike Naberezny](http://github.com/mnaberez) is the author of TDMS for
Ruby.  Development is sponsored by [Maintainable](http://maintainable.com).
