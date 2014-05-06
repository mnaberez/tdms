require 'date'

module Tdms

  module Streaming
    def read_property
      name    = read_utf8_string
      type_id = read_u32

      data = Tdms::DataType.find_by_id(type_id).read_from_stream(self)
      Tdms::Property.new(name, data)
    end

    def read_bool
      read(1) == "\001"
    end

    def read_u8
      read(1).unpack("C")[0]
    end

    def read_u16
      read(2).unpack("v")[0]
    end

    def read_u32
      read(4).unpack("V")[0]
    end

    def read_u64
      lo_hi = read(8).unpack("VV")
      lo_hi[0] + (lo_hi[1] << 32)
    end

    def read_i8
      read(2).unpack("c")[0]
    end

    def read_i16
      read(2).unpack("s")[0] # TODO little endian not native
    end

    def read_i32
      read(4).unpack("l")[0] # TODO little endian not native
    end

    def read_i64
      read(8).unpack("q")[0] # TODO little endian not native
    end

    def read_single
      read(4).unpack("e")[0]
    end

    def read_double
      read(8).unpack("E")[0]
    end

    def read_utf8_string
      length = read_u32
      read length
    end

    def read_timestamp
      positive_fractions_of_second = read_u64 # ignored
      seconds_since_labview_epoch  = read(8).unpack("q")[0] # TODO little endian not native

      labview_epoch = ::DateTime.new(1904, 1, 1)
      labview_epoch + Rational(seconds_since_labview_epoch, 86400)
    end
  end

  class File < ::File
    include Streaming

    def self.parse(filename)
      f = self.open(filename, "rb")
      Document.new(f)
    end
  end

end
