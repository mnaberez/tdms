module Tdms

  class Path
    attr_reader :group, :channel

    def initialize(options={})
      load(options[:path]) if options[:path]
      @group   = options[:group]   if options[:group]
      @channel = options[:channel] if options[:channel]
    end

    def load(path)
      segments = path.split("/").map do |seg|
        seg.sub(/^'/,'').sub(/'$/,'').sub("''", "'")
      end

      _, @group, @channel = *segments
    end

    def ==(other)
      if other.is_a?(String)
        self.to_s == other
      elsif other.is_a?(Path)
        self.dump == other.dump
      else
        super
      end
    end

    def dump
      raise ArgumentError if channel && group.nil?

      parts = [""]
      parts << ("'" + group.sub("'","''")   + "'") if group
      parts << ("'" + channel.sub("'","''") + "'") if channel

      dumped = parts.join("/")
      dumped.empty? ? "/" : dumped
    end

    def to_s
      dump
    end

    def root?
      (! channel?) && (! group?)
    end

    def group?
      (! @group.nil?) && (@channel.nil?)
    end

    def channel?
      (! @channel.nil?)
    end
  end

end
