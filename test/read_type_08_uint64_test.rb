class ReadType08Uint64Test < Test::Unit::TestCase

  def test_reads_one_uint64_channel_in_one_segment
    filename = fixture_filename("type_08_uint64_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Uint64::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint64_group'/'uint64_channel'" }
    assert_equal 5, chan.values.size

    expected = [0, 1, 4_294_967_295, 9_223_372_036_854_775_807, 18_446_744_073_709_551_615]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_uint64_channels_in_one_segment
    filename = fixture_filename("type_08_uint64_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Uint64::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint64::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint64_group'/'uint64_channel_a'" }
    assert_equal 5, chan.values.size
    expected = [0, 1, 4_294_967_295, 9_223_372_036_854_775_807, 18_446_744_073_709_551_615]
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'uint64_group'/'uint64_channel_b'" }
    assert_equal 5, chan.values.size
    expected = [18_446_744_073_709_551_615, 9_223_372_036_854_775_807, 4_294_967_295, 1, 0]
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_uint64_channel_across_three_segments
    filename = fixture_filename("type_08_uint64_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Uint64::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint64::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Uint64::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'uint64_group'/'uint64_channel'" }
    assert_equal 15, chan.values.size
    expected = [0, 1, 4_294_967_295, 9_223_372_036_854_775_807, 18_446_744_073_709_551_615,
                0, 1, 4_294_967_295, 9_223_372_036_854_775_807, 18_446_744_073_709_551_615,
                0, 1, 4_294_967_295, 9_223_372_036_854_775_807, 18_446_744_073_709_551_615]
    assert_equal expected, chan.values.to_a
  end

end
