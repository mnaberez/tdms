This directory contains VIs for LabVIEW 2010 that are used to
build the test fixtures.

LabVIEW 2010 saves floats with units (tdsTypeSingleFloatWithUnit,
tdsTypeDoubleFloatWithUnit, tdsTypeExtendedTypeWithUnit) with the
channel data type as floats without units.  
These fixtures were made by hand:

  tdsTypeDoubleFloatWithUnit
   Fixtures type_1a_*.tdms are the same as type_0a_*.tdms but the
   channel data type was edited from tdsTypeDoubleFloat (0x0A) to
   tdsTypeDoubleFloatWithUnit (0x1A).
