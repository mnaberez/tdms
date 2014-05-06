class ReadType03Int32Test < Test::Unit::TestCase

  def test_reads_one_int32_channel_in_one_segment
    filename = fixture_filename("type_03_int32_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Int32::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int32_group'/'int32_channel'" }
    assert_equal 5, chan.values.size

    expected = [-2_147_483_648, -1_073_741_824, 0, 10_737_41_823, 2_147_483_647]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_int32_channels_in_one_segment
    filename = fixture_filename("type_03_int32_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Int32::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Int32::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int32_group'/'int32_channel_a'" }
    assert_equal 5, chan.values.size
    expected = [-2_147_483_648, -1_073_741_824, 0, 10_737_41_823, 2_147_483_647]
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'int32_group'/'int32_channel_b'" }
    assert_equal 5, chan.values.size
    expected = [2_147_483_647, 1_073_741_823, 0, -1_073_741_824, -2_147_483_648]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_int32_channel_across_three_segments
    filename = fixture_filename("type_03_int32_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Int32::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Int32::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Int32::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'int32_group'/'int32_channel'" }
    assert_equal 15, chan.values.size
    expected = [-2_147_483_648, -1_073_741_824, 0, 10_737_41_823, 2_147_483_647,
                -2_147_483_648, -1_073_741_824, 0, 10_737_41_823, 2_147_483_647,
                -2_147_483_648, -1_073_741_824, 0, 10_737_41_823, 2_147_483_647]
    assert_equal expected, chan.values.to_a
  end

end
