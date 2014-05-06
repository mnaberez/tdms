class ReadType44TimestampTest < Test::Unit::TestCase

  def test_reads_one_timestamp_channel_in_one_segment
    filename = fixture_filename("type_44_timestamp_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Timestamp::Id, doc.segments[0].objects[0].data_type_id


    chan = doc.channels.find {|ch| ch.path == "/'timestamp_group'/'timestamp_channel'" }
    assert_equal 3, chan.values.size

    expected = ["1904-01-01 00:00:00", "2008-06-07 01:23:45", "1894-03-15 13:23:45"]
    assert_equal expected, chan.values.map { |dt| dt.strftime("%Y-%m-%d %H:%M:%S") }
  end

  def test_reads_two_timestamp_channels_in_one_segment
    filename = fixture_filename("type_44_timestamp_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Timestamp::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Timestamp::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'timestamp_group'/'timestamp_channel_a'" }
    assert_equal 3, chan.values.size
    expected = ["1904-01-01 00:00:00", "2008-06-07 01:23:45", "1894-03-15 13:23:45"]
    assert_equal expected, chan.values.map { |dt| dt.strftime("%Y-%m-%d %H:%M:%S") }

    chan = doc.channels.find {|ch| ch.path == "/'timestamp_group'/'timestamp_channel_b'" }
    assert_equal 3, chan.values.size
    expected = ["1894-03-15 13:23:45", "2008-06-07 01:23:45", "1904-01-01 00:00:00"]
    assert_equal expected, chan.values.map { |dt| dt.strftime("%Y-%m-%d %H:%M:%S") }
  end

  def test_reads_one_timestamp_channel_across_three_segments
    filename = fixture_filename("type_44_timestamp_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Timestamp::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Timestamp::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Timestamp::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'timestamp_group'/'timestamp_channel'" }
    assert_equal 9, chan.values.size

    expected = ["1904-01-01 00:00:00", "2008-06-07 01:23:45", "1894-03-15 13:23:45",
                "1904-01-01 00:00:00", "2008-06-07 01:23:45", "1894-03-15 13:23:45",
                "1904-01-01 00:00:00", "2008-06-07 01:23:45", "1894-03-15 13:23:45"]
    assert_equal expected, chan.values.map { |dt| dt.strftime("%Y-%m-%d %H:%M:%S") }
  end

end
