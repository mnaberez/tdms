require 'rubygems'
require 'active_support/all'

module Tdms
  
  module Streaming
    def read_property
      name    = read_utf8_string
      type_id = read_u32
      
      data = Tdms::DataType.find_by_id(type_id).read_from_stream(self)
      Tdms::Property.new(name, data)
    end

    def read_bool
      read(1) == "\001" ? true : false
    end

    def read_u8
      read(1).unpack("C")[0]
    end

    def read_u32
      read(4).unpack("V")[0]
    end

    def read_i32
      read_u32 # XXX
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
      seconds_since_labview_epoch  = read(8).unpack("Q")[0]
      positive_fractions_of_second = read(8).unpack("Q")[0] # ignored
      
      labview_epoch = ::DateTime.new(1904, 1, 1)
      labview_epoch.advance(:seconds => seconds_since_labview_epoch)
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
