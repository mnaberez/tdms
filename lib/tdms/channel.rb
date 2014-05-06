module Tdms

  class Channel < Object
    attr_accessor :file, :path, :data_type_id, :dimension, :num_values,
                  :raw_data_pos

    def name
      path.channel
    end

    def values
      @values ||= begin
        klass = if data_type::LengthInBytes.nil?
          StringChannelEnumerator
        else
          ChannelEnumerator
        end

        klass.new(self)
      end
    end

    def data_type
      @data_type ||= DataType.find_by_id(data_type_id)
    end
  end

  class ChannelEnumerator
    include Enumerable

    def initialize(channel)
      @channel = channel
    end

    def size
      @size ||= @channel.num_values
    end

    def each
      0.upto(size - 1) { |i| yield self[i] }
    end

    def [](i)
      if (i < 0) || (i >= size)
        raise RangeError, "Channel %s has a range of 0 to %d, got invalid index: %d" %
                          [@channel.path, size - 1, i]
      end

      @channel.file.seek @channel.raw_data_pos + (i * @channel.data_type::LengthInBytes)
      @channel.data_type.read_from_stream(@channel.file).value
    end
  end

  class StringChannelEnumerator
    include Enumerable

    def initialize(channel)
      @channel = channel

      @index_pos = @channel.raw_data_pos
      @data_pos  = @index_pos + (4 * @channel.num_values)
    end

    def size
      @size ||= @channel.num_values
    end

    def each
      data_pos = @data_pos

      0.upto(size - 1) do |i|
        index_pos = @index_pos + (4 * i)

        @channel.file.seek index_pos
        next_data_pos = @data_pos + @channel.file.read_u32

        length = next_data_pos - data_pos

        @channel.file.seek data_pos
        yield @channel.file.read(length)

        data_pos = next_data_pos
      end
    end

    def [](i)
      if (i < 0) || (i >= size)
        raise RangeError, "Channel %s has a range of 0 to %d, got invalid index: %d" %
                          [@channel.path, size - 1, i]
      end

      inject(0) do |j, value|
        return value if j == i
        j += 1
      end
    end

  end

end
