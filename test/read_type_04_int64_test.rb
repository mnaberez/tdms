class ReadType04Int64Test < Test::Unit::TestCase

  def test_reads_one_int64_channel_in_one_segment
    filename = fixture_filename("type_04_int64_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Int64::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int64_group'/'int64_channel'" }
    assert_equal 5, chan.values.size

    expected = [-9_223_372_036_854_775_808, -4_611_686_018_427_387_904, 0,
                4_611_686_018_427_387_903, 9_223_372_036_854_775_807]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_int64_channels_in_one_segment
    filename = fixture_filename("type_04_int64_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Int64::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Int64::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int64_group'/'int64_channel_a'" }
    assert_equal 5, chan.values.size
    expected = [-9_223_372_036_854_775_808, -4_611_686_018_427_387_904, 0,
                4_611_686_018_427_387_903, 9_223_372_036_854_775_807]
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'int64_group'/'int64_channel_b'" }
    assert_equal 5, chan.values.size
    expected = [9_223_372_036_854_775_807, 4_611_686_018_427_387_903, 0,
                -4_611_686_018_427_387_904, -9_223_372_036_854_775_808]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_int64_channel_across_three_segments
    filename = fixture_filename("type_04_int64_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Int64::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Int64::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Int64::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int64_group'/'int64_channel'" }
    assert_equal 15, chan.values.size
    expected = [-9_223_372_036_854_775_808, -4_611_686_018_427_387_904, 0,
                4_611_686_018_427_387_903, 9_223_372_036_854_775_807,
                -9_223_372_036_854_775_808, -4_611_686_018_427_387_904, 0,
                4_611_686_018_427_387_903, 9_223_372_036_854_775_807,
                -9_223_372_036_854_775_808, -4_611_686_018_427_387_904, 0,
                4_611_686_018_427_387_903, 9_223_372_036_854_775_807,]
    assert_equal expected, chan.values.to_a
  end

end
