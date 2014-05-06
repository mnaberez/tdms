class ReadType05Uint8Test < Test::Unit::TestCase

  def test_reads_one_uint8_channel_in_one_segment
    filename = fixture_filename("type_05_uint8_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Uint8::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel'" }
    assert_equal 5, chan.values.size

    expected = [0, 1, 62, 127, 255]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_uint8_channels_in_one_segment
    filename = fixture_filename("type_05_uint8_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Uint8::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint8::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel_a'" }
    assert_equal 5, chan.values.size
    expected = [0, 1, 62, 127, 255]
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel_b'" }
    assert_equal 5, chan.values.size
    expected = [255, 127, 62, 1, 0]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_uint8_channel_across_three_segments
    filename = fixture_filename("type_05_uint8_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Uint8::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint8::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint8::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint8_group'/'uint8_channel'" }
    assert_equal 15, chan.values.size
    expected = [0, 1, 62, 127, 255, 0, 1, 62, 127, 255, 0, 1, 62, 127, 255]
    assert_equal expected, chan.values.to_a
  end

end
