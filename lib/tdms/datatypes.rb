module Tdms

  module DataType

    class Base
      attr_accessor :value
      
      def initialize(value=nil)
        @value = value
      end
    end

    class Int32 < Base
      Id = 0x03
      LengthInBytes = 4
      
      def self.read_from_stream(tdms_file)
        new(tdms_file.read_i32)
      end
    end

    class Uint8 < Base
      Id = 0x05
      LengthInBytes = 1
      
      def self.read_from_stream(tdms_file)
        new(tdms_file.read_u8)
      end
    end

    class Uint16 < Base
      Id = 0x06
      LengthInBytes = 2
      
      def self.read_from_stream(tdms_file)
        new(tdms_file.read_u16)
      end
    end

    class Single < Base
      Id = 0x09
      LengthInBytes = 4

      def self.read_from_stream(tdms_file)
        new(tdms_file.read_single)
      end
    end
    
    class Double < Base
      Id = 0x0A
      LengthInBytes = 8

      def self.read_from_stream(tdms_file)
        new(tdms_file.read_double)
      end
    end

    class Utf8String < Base
      Id = 0x20
      LengthInBytes = nil

      def self.read_from_stream(tdms_file)
        new(tdms_file.read_utf8_string)
      end
    end

    class Boolean < Base
      Id = 0x21
      LengthInBytes = 1
      
      def self.read_from_stream(tdms_file)
        new(tdms_file.read_bool)
      end
    end

    class Timestamp < Base
      Id = 0x44
      LengthInBytes = 16
      
      def self.read_from_stream(tdms_file)
        new(tdms_file.read_timestamp)
      end
    end

    DataTypesById = {
      Int32::Id      => Int32,
      Uint8::Id      => Uint8,
      Uint16::Id     => Uint16,
      Single::Id     => Single,
      Double::Id     => Double,
      Utf8String::Id => Utf8String,
      Boolean::Id    => Boolean,
      Timestamp::Id  => Timestamp
    }

    def find_by_id(id_byte)
      DataTypesById[id_byte] || raise(ArgumentError, "Don't know type %d" % id_byte)
    end
    module_function :find_by_id

  end

end
