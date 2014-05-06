module Tdms

  class AggregateChannel
    def initialize(channels=[])
      @channels = channels
    end

    def path
      @channels[0].path
    end

    def name
      @channels[0].name
    end

    def data_type
      @channels[0].data_type
    end

    def values
      @values ||= AggregateChannelEnumerator.new(@channels)
    end
  end

  class AggregateChannelEnumerator
    include Enumerable

    def initialize(channels)
      @channels = channels
      @offsets  = []

      size = 0
      @channels.inject(0) do |size, channel|
        @offsets << size
        size += channel.values.size
      end
    end

    def size
      @size ||= @channels.inject(0) { |sum, chan| sum += chan.values.size }
    end

    def each
      @channels.each do |channel|
        channel.values.each { |value| yield value }
      end
    end

    def [](i)
      if (i < 0) || (i >= size)
        raise RangeError, "Channel %s has a range of 0 to %d, got invalid index: %d" %
                          [@channels[0].path, size - 1, i]
      end

      channel, offset = nil, nil
      j = @offsets.size - 1
      @offsets.reverse_each do |o|
        if i >= o
          channel = @channels[j]
          offset  = @offsets[j]
          break
        else
          j -= 1
        end
      end

      channel.values[i - offset]
    end
  end

end