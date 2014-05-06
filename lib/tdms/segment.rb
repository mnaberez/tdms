module Tdms

  class Segment
    attr_accessor :prev_segment
    attr_reader :objects

    def initialize
      @objects = []
    end
  end

end
