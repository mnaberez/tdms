This directory contains VIs for LabVIEW 2010 that are used to
build the test fixtures.

LabVIEW 2010 saves floats with units (tdsTypeSingleFloatWithUnit,
tdsTypeDoubleFloatWithUnit, tdsTypeExtendedTypeWithUnit) with the
channel data type as floats without units.  
These fixtures were made by hand:

  tdsTypeSingleFloatWithUnit
    Fixtures type_19_*.tdms are the same as type_09_*.tdms but the
    channel data type was edited from tdsTypeSingleFloat (0x09) to
    tdsTypeSingleFloatWithUnit (0x19).

  tdsTypeDoubleFloatWithUnit
   Fixtures type_1a_*.tdms are the same as type_0a_*.tdms but the
   channel data type was edited from tdsTypeDoubleFloat (0x0A) to
   tdsTypeDoubleFloatWithUnit (0x1A).

LabVIEW 2010 saves booleans (tdsTypeBoolean) as 8-bit unsigned
integers (tdsTypeU8).  These fixtures were made by hand:

  tdsTypeBoolean
    Each type_21_*.tdms fixture was made by running the corresponding
    VI but the channel data type was edited from tdsTypeU8 (0x05)
    to tdsTypeBoolean (0x21).
