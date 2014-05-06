class ReadType01Int8Test < Test::Unit::TestCase

  def test_reads_one_int8_channel_in_one_segment
    filename = fixture_filename("type_01_int8_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Int8::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int8_group'/'int8_channel'" }
    assert_equal 5, chan.values.size

    expected = [-128, -64, 0, 63, 127]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_int8_channels_in_one_segment
    filename = fixture_filename("type_01_int8_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Int8::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Int8::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int8_group'/'int8_channel_a'" }
    assert_equal 5, chan.values.size
    expected = [-128, -64, 0, 63, 127]
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'int8_group'/'int8_channel_b'" }
    assert_equal 5, chan.values.size
    expected = [127, 63, 0, -64, -128]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_int8_channel_across_three_segments
    filename = fixture_filename("type_01_int8_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Int8::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Int8::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Int8::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int8_group'/'int8_channel'" }
    assert_equal 15, chan.values.size
    expected = [-128, -64, 0, 63, 127,
                -128, -64, 0, 63, 127,
                -128, -64, 0, 63, 127]
    assert_equal expected, chan.values.to_a
  end

end
