class ReadType05Uint8Test < Test::Unit::TestCase
  
  def test_reads_one_boolean_channel_in_one_segment
    filename = fixture_filename("type_05_uint8_one_segment")
    doc = Tdms::File.parse(filename)
  
    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    
    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel'" }
    assert_equal 4, chan.values.size
    
    expected = [1, 0, 1, 0]
    assert_equal expected, chan.values.to_a
  end
  
  def test_reads_two_boolean_channels_in_one_segment
    filename = fixture_filename("type_05_uint8_two_channels_one_segment")
    doc = Tdms::File.parse(filename)
  
    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
  
    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel_a'" }
    assert_equal 4, chan.values.size
    expected = [1, 0, 1, 0]
    assert_equal expected, chan.values.to_a
  
    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel_b'" }
    assert_equal 4, chan.values.size
    expected = [0, 1, 0, 1]
    assert_equal expected, chan.values.to_a
  end
  
  def test_reads_one_boolean_channel_across_two_segments
    filename = fixture_filename("type_05_uint8_two_segments")
    doc = Tdms::File.parse(filename)
  
    assert_equal 2, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size

    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel'" }
    assert_equal 8, chan.values.size
    expected = [1, 0, 1, 0, 1, 0, 1, 0]
    assert_equal expected, chan.values.to_a
  end

end
