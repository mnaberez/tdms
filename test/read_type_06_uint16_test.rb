class ReadType06Uint16Test < Test::Unit::TestCase

  def test_reads_one_uint16_channel_in_one_segment
    filename = fixture_filename("type_06_uint16_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Uint16::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint16_group'/'uint16_channel'" }
    assert_equal 5, chan.values.size

    expected = [0, 1, 16_383, 32_767, 65_535]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_uint16_channels_in_one_segment
    filename = fixture_filename("type_06_uint16_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Uint16::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint16::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint16_group'/'uint16_channel_a'" }
    assert_equal 5, chan.values.size
    expected = [0, 1, 16_383, 32_767, 65_535]
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'uint16_group'/'uint16_channel_b'" }
    assert_equal 5, chan.values.size
    expected = [65_535, 32_767, 16_383, 1, 0]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_uint16_channel_across_three_segments
    filename = fixture_filename("type_06_uint16_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Uint16::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint16::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint16::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint16_group'/'uint16_channel'" }
    assert_equal 15, chan.values.size
    expected = [0, 1, 16_383, 32_767, 65_535,
                0, 1, 16_383, 32_767, 65_535,
                0, 1, 16_383, 32_767, 65_535]
    assert_equal expected, chan.values.to_a
  end

end
